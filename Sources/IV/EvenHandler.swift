//
//  EvenHandler.swift
//  IVExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

/// A protocol that handles events.
public protocol EventHandler {
    associatedtype Event
    func handle(event: Event)
}
