//
//  Todo.swift
//  Todo-List
//
//  Created by Abdelrahman Sobhy on 5/3/20.
//  Copyright © 2020 Macbook pro. All rights reserved.
//

import Foundation
struct Todo : Codable {
    let item : String
    let priority : Int
}

struct Todos : Codable {
    let items : [Todo]
}
