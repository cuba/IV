//
//  VIExampleTests.swift
//  VIExampleTests
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import XCTest
import VI
@testable import VIExample

class VIExampleTests: XCTestCase {
    func testInteractor() {
        let showUsersTriggered = expectation(description: "Show users triggered")
        let view = MockView<UsersListInteractor>()
        var interactor = UsersListInteractor()
        view.configure(with: &interactor)
        
        view.emit(.didLoadView) { command in
            switch command {
            case .showUsers:
                showUsersTriggered.fulfill()
            }
        }
        
        wait(for: [
            showUsersTriggered
        ], timeout: 10, enforceOrder: true)
    }
}
