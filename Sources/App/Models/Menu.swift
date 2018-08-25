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
    var imageID: Image.ID
    
    init(name: String, description: String, price: Double, imageID: Image.ID) {
        self.name = name
        self.description = description
        self.price = price
        self.imageID = imageID
    }
}

extension Menu: PostgreSQLModel {}
extension Menu: Content {}
extension Menu: Parameter {}

extension Menu {
    var image: Parent<Menu, Image> {
        return parent(\.imageID)
    }
    
    var categories: Siblings<Menu, Category, MenuCategoryPivot> {
        return siblings()
    }
}

extension Menu: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.imageID, to: \Image.id)
        }
    }
}
