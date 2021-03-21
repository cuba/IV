//
//  UsersListInteractor.swift
//  
//
//  Created by Jacob Sikorski on 2021-03-21.
//

import Foundation
@testable import IV

class UsersListInteractor: InteractorProtocol {
    var commandEmitter: CommandEmitter<UsersListCommand>?
    
    public func handle(event: UsersListEvent) {
        switch event {
        case .didLoadView:
            emit(command: .showItems)
        }
    }
}

