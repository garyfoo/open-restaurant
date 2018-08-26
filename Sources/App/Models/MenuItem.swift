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
    var imageName: URL?
    
    init(name: String, description: String, price: Double) {
        self.name = name
        self.description = description
        self.price = price
    }
}

extension MenuItem: PostgreSQLModel {}
extension MenuItem: Content {}
extension MenuItem: Migration {}
extension MenuItem: Parameter {}

extension MenuItem {
    
    var categories: Siblings<MenuItem, Category, MenuItemCategoryPivot> {
        return siblings()
    }
    
}
