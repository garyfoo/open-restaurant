//
//  MenuCategoryPivot.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Vapor
import FluentPostgreSQL
import Foundation

final class MenuCategoryPivot: PostgreSQLUUIDPivot, ModifiablePivot {

    var id: UUID?
    var menuID: Menu.ID
    var categoryID: Category.ID
    
    typealias Left = Menu
    typealias Right = Category

    static let leftIDKey: LeftIDKey = \.menuID
    static let rightIDKey: RightIDKey = \.categoryID

    init(_ menu: Menu, _ category: Category) throws {
        self.menuID = try menu.requireID()
        self.categoryID = try category.requireID()
    }
}

extension MenuCategoryPivot: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.menuID, to: \Menu.id, onDelete: .cascade)
            builder.reference(from: \.categoryID, to: \Category.id, onDelete: .cascade)
        }
    }
}
