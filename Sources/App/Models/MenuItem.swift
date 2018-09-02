//
//  Menu.swift
//  App
//
//  Created by Gary Foo on 31/7/18.
//

import Vapor
import FluentPostgreSQL

final class MenuItem: Codable {
    var id: Int?
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageName: URL?
    
    init(name: String, description: String, price: Double, category: String) {
        self.name = name
        self.description = description
        self.price = price
        self.category = category
    }
}

extension MenuItem: PostgreSQLModel {}
extension MenuItem: Content {}
extension MenuItem: Migration {}
extension MenuItem: Parameter {}


struct Items: Content {
    var items: [MenuItem]
}
