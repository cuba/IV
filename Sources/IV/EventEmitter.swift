//
//  EventEmitter.swift
//  IVExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

/// Wrapper object that helps us emit events without having direct access to the event handler.
public struct EventEmitter<Handler: EventHandler> {
    let handler: Handler
    
    public init(handler: Handler) {
        self.handler = handler
    }
    
    public func emit(_ event: Handler.Event) {
        handler.handle(event: event)
    }
}
