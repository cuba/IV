//
//  MockView.swift
//  VIExampleTests
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

public class MockView<Interactor: InteractorProtocol>: ViewProtocol {
    // MARK: - Injected
    public var eventEmitter: EventEmitter<Interactor>?
    private var commandCallback: ((Interactor.Command) -> Void)?
    
    public func handle(command: Interactor.Command) {
        commandCallback?(command)
    }
    
    public func emit(_ event: Interactor.Event, callback: @escaping (Interactor.Command) -> Void) {
        self.commandCallback = callback
        emit(event: event)
    }
}
