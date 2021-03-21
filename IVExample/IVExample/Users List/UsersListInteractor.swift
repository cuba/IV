//
//  UsersListInteractor.swift
//  IVExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation
import IV

class UsersListInteractor: InteractorProtocol {
    // MARK: - Injected
    var commandEmitter: CommandEmitter<UsersListCommand>?
    
    private var users: [User] = []
    
    func handle(event: UsersListEvent) {
        switch event {
        case .didLoadView:
            fetchUsers()
        }
    }
    
    func fetchUsers() {
        // You can replace this with an async call
        self.users = [
            User(id: UUID(), firstName: "Jim", lastName: "Halpert"),
            User(id: UUID(), firstName: "Pam", lastName: "Beesly"),
            User(id: UUID(), firstName: "Michael", lastName: "Scott"),
            User(id: UUID(), firstName: "Kevin", lastName: "Malone")
        ]
        
        let items = users.map({ SimpleListItem(title: $0.fullName, subtitle: $0.id.uuidString) })
        emit(command: .showItems(items))
    }
}
