//
//  CommandEmitter.swift
//  VIExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

/// Wrapper object that helps us emit commands without having direct access to the event handler.
public struct CommandEmitter<Command> {
    private var callback: (Command) -> Void
    
    public init(callback: @escaping (Command) -> Void) {
        self.callback = callback
    }
    
    public func emit(_ command: Command) {
        callback(command)
    }
    
    public func emit(_ commands: [Command]) {
        commands.forEach { callback($0) }
    }
}
