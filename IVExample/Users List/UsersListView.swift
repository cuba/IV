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
    
    private let reuseIdentifier = "cell"
    private var items: [SimpleListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        
        // This configuraton can be moved outside into an assembly if you prefer
        var interator = UsersListInteractor()
        link(&interator)
        
        // Emit an event
        eventEmitter?.emit(.didLoadView)
    }
    
    func handle(command: UsersListCommand) {
        switch command {
        case .showItems(let items):
            self.items = items
            tableView.reloadData()
        }
    }
}

extension UsersListView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        
        return cell
    }
}
