//
//  User.swift
//  IVExample
//
//  Created by Jacob Sikorski on 2020-01-12.
//  Copyright © 2020 Jacob Sikorski. All rights reserved.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    let firstName: String
    let lastName: String
    
    var fullName: String {
        return [firstName, lastName].joined(separator: " ")
    }
}
