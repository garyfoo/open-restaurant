//
//  Image.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Foundation
import Vapor
import FluentPostgreSQL

final class Image: Codable {
    var id: UUID?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Image: PostgreSQLUUIDModel {}
extension Image: Content {}
extension Image: Migration {}
extension Image: Parameter {}

extension Image {
    var menus: Children<Image, Menu> {
        return children(\.imageID)
    }
}
