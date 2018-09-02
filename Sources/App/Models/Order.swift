//
//  Order.swift
//  App
//
//  Created by Gary Foo on 27/8/18.
//

import Vapor
import FluentPostgreSQL

final class Order: Codable {
    var id: Int?
    var menuIds: [Int]
    var timestamp: Date
    
    init(menuIds: [Int], timestamp: Date) {
        self.menuIds = menuIds
        self.timestamp = Date()
    }
}

extension Order: PostgreSQLModel {}
extension Order: Content {}
extension Order: Migration {}
