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
//    var imageID: ImageItem.ID
//    var categories: Siblings<MenuItem, Category, MenuItemCategoryPivot> {
//        return siblings()
//    }
    init(name: String, description: String, price: Double) {
        self.name = name
        self.description = description
        self.price = price
    }
}

extension Menu: PostgreSQLModel {}
extension Menu: Content {}
extension Menu: Parameter {}

//extension MenuItem {
//    var user: Parent<MenuItem, ImageItem> {
//        return parent(\.imageID)
//    }
//}
//
//extension MenuItem: Migration {
//    static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
//        return Database.create(self, on: connection) { builder in
//            try addProperties(to: builder)
//            builder.reference(from: \.imageitemID, to: \ImageItem.id)
//        }
//    }
//}
