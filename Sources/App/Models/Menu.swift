//
//  Menu.swift
//  App
//
//  Created by Gary Foo on 31/7/18.
//

import Vapor
import FluentPostgreSQL

final class Menu: Codable {
    var id: Int?
    var name: String
    var description: String
    var price: Double
    var categories: Siblings<Menu, Category, MenuCategoryPivot> {
        return siblings()
    }
    
    init(name: String, description: String, price: Double) {
        self.name = name
        self.description = description
        self.price = price
    }
}

extension Menu: PostgreSQLModel {}
extension Menu: Content {}
extension Menu: Migration {}
extension Menu: Parameter {}
