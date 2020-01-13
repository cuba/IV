//
//  InteractorProtocol.swift
//  VIExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

/// A protocol that defines the Interactor object. In other words it handles events and emits commands.
public protocol InteractorProtocol: class, EventHandler {
    associatedtype Command
    
    var commandEmitter: CommandEmitter<Command>? { get set }
}
