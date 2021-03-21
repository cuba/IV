//
//  MockInteractor.swift
//  
//
//  Created by Jacob Sikorski on 2021-03-21.
//

import Foundation
@testable import IV

class MockInteractor: InteractorProtocol {
    var commandEmitter: CommandEmitter<MockCommand>?
    
    public func handle(event: MockEvent) {
        switch event {
        case .didLoadView:
            emit(command: .showItems)
        }
    }
}

