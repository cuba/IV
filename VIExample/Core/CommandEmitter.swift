//
//  CommandEmitter.swift
//  VIExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

struct CommandEmitter<Command> {
    var callback: (Command) -> Void
    
    init(callback: @escaping (Command) -> Void) {
        self.callback = callback
    }
    
    func emit(_ command: Command) {
        callback(command)
    }
    
    func emit(_ commands: [Command]) {
        commands.forEach { callback($0) }
    }
}
