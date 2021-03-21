//
//  ViewProtocol.swift
//  IVExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

/// A protocol that defines the View object. In other words it handles commands and emits events.
public protocol ViewProtocol: class {
    associatedtype Interactor: InteractorProtocol
    
    var eventEmitter: EventEmitter<Interactor>? { get set }
    
    func handle(command: Interactor.Command)
}

extension ViewProtocol {
    func emit(event: Interactor.Event) {
        eventEmitter?.emit(event)
    }
    
    func emit(events: [Interactor.Event]) {
        for event in events {
            emit(event: event)
        }
    }
}

