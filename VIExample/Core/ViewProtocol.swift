//
//  ViewProtocol.swift
//  VIExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

protocol ViewProtocol: class {
    associatedtype Interactor: InteractorProtocol
    
    var eventEmitter: EventEmitter<Interactor>? { get set }
    
    func handle(command: Interactor.Command)
}

extension ViewProtocol {
    func configure(with interactor: inout Interactor) {
        eventEmitter = EventEmitter<Interactor>(handler: interactor)
        
        let commandEmitter = CommandEmitter<Interactor.Command>(callback: { [weak self] command in
            self?.handle(command: command)
        })
        
        interactor.commandEmitter = commandEmitter
    }
}
