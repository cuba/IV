//
//  ViewProtocol.swift
//  VIExample
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

public extension ViewProtocol {
    /// Configure this view with an interactor. It will link the view to the interactor and vice-versa
    func configure(with interactor: inout Interactor) {
        eventEmitter = EventEmitter<Interactor>(handler: interactor)
        
        let commandEmitter = CommandEmitter<Interactor.Command>(callback: { [weak self] command in
            self?.handle(command: command)
        })
        
        interactor.commandEmitter = commandEmitter
    }
}
