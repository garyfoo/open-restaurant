//
//  Category.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Vapor
import FluentPostgreSQL

final class Category: Codable {
    var id: Int?
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Category: PostgreSQLModel {}
extension Category: Content {}
extension Category: Migration {}
extension Category: Parameter {}

struct Categories: Content {
    let categories: [String]
}
