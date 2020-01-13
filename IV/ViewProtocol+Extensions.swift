//
//  ViewProtocol+Extensions.swift
//  IV
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

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
