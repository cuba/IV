//
//  UsersListView.swift
//  IVExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import UIKit
import IV

class UsersListView: UITableViewController, ViewProtocol {
    // MARK: - Injected
    var eventEmitter: EventEmitter<UsersListInteractor>?
    
    // We can replace this with view models
    private let reuseIdentifier = "cell"
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        
        eventEmitter?.emit(.didLoadView)
    }
    
    func handle(command: UsersListCommand) {
        switch command {
        case .showUsers(let users):
            self.users = users
            tableView.reloadData()
        }
    }
}

extension UsersListView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let user = users[indexPath.row]
        cell.textLabel?.text = [user.firstName, user.lastName].joined(separator: " ")
        cell.detailTextLabel?.text = user.id.uuidString
        
        return cell
    }
}
