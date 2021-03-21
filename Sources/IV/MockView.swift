//
//  MockView.swift
//  VIExampleTests
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

public class MockView<I: InteractorProtocol>: ViewProtocol {
    // MARK: - Injected
    public var eventEmitter: EventEmitter<I>?
    private var commandCallback: ((I.Command) -> Void)?
    
    public init() {}
    
    public func handle(command: I.Command) {
        commandCallback?(command)
    }
    
    public func emit(_ event: I.Event, callback: @escaping (I.Command) -> Void) {
        self.commandCallback = callback
        eventEmitter?.emit(event)
    }
}
