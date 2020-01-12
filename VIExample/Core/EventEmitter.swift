//
//  EventEmitter.swift
//  VIExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

/// Wrapper object that helps us emit events without having direct access to the event handler.
struct EventEmitter<Handler: EventHandler> {
    private var handler: Handler
    
    init(handler: Handler) {
        self.handler = handler
    }
    
    func emit(_ event: Handler.Event) {
        handler.handle(event: event)
    }
}
