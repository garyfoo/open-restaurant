//
//  Order.swift
//  App
//
//  Created by Gary Foo on 27/8/18.
//

import Vapor

struct Order: Content {
    var menuIds: [Int]
}

struct PreparationTime: Content {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
