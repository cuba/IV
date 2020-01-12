//
//  MockView.swift
//  VIExampleTests
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

@testable import VIExample

class MockView<I: InteractorProtocol>: ViewProtocol {
    // MARK: - Injected
    var eventEmitter: EventEmitter<I>?
    private var commandCallback: ((I.Command) -> Void)?
    
    init() {}
    
    func handle(command: I.Command) {
        commandCallback?(command)
    }
    
    func emit(_ event: I.Event, callback: @escaping (I.Command) -> Void) {
        self.commandCallback = callback
        eventEmitter?.emit(event)
    }
}
