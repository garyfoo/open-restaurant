//
//  MenuCategoryPivot.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Vapor
import FluentPostgreSQL
import Foundation

final class MenuItemCategoryPivot: PostgreSQLUUIDPivot, ModifiablePivot {

    var id: UUID?
    var menuItemID: MenuItem.ID
    var categoryID: Category.ID
    
    typealias Left = MenuItem
    typealias Right = Category

    static let leftIDKey: LeftIDKey = \.menuItemID
    static let rightIDKey: RightIDKey = \.categoryID

    init(_ menuItem: MenuItem, _ category: Category) throws {
        self.menuItemID = try menuItem.requireID()
        self.categoryID = try category.requireID()
    }
}

extension MenuItemCategoryPivot: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.menuItemID, to: \MenuItem.id, onDelete: .cascade)
            builder.reference(from: \.categoryID, to: \Category.id, onDelete: .cascade)
        }
    }
}
