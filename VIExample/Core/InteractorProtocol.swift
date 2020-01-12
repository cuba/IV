//
//  InteractorProtocol.swift
//  VIExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

protocol InteractorProtocol: class, EventHandler {
    associatedtype Command
    
    var commandEmitter: CommandEmitter<Command>? { get set }
}
