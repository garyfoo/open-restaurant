//
//  MenuItemImagePivot.swift
//  App
//
//  Created by Gary Foo on 26/8/18.
//

import Vapor
import FluentPostgreSQL
import Foundation

final class MenuItemImagePivot: PostgreSQLUUIDPivot, ModifiablePivot {
    
    var id: UUID?
    var menuItemID: MenuItem.ID
    var imageID: Image.ID
    
    typealias Left = MenuItem
    typealias Right = Image
    
    static let leftIDKey: LeftIDKey = \.menuItemID
    static let rightIDKey: RightIDKey = \.imageID
    
    init(_ menuItem: MenuItem, _ image: Image) throws {
        self.menuItemID = try menuItem.requireID()
        self.imageID = try image.requireID()
    }
}

extension MenuItemImagePivot: Migration {
    static func prepare(on connection: PostgreSQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.menuItemID, to: \MenuItem.id, onDelete: .cascade)
            builder.reference(from: \.imageID, to: \Image.id, onDelete: .cascade)
        }
    }
}
