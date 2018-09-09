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
    var imageName: URL
    
    init(name: String, description: String, price: Double, category: String, imageName: URL) {
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.imageName = imageName
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case category
        case imageName = "image_url"
    }
}

extension MenuItem: PostgreSQLModel {}
extension MenuItem: Content {}
extension MenuItem: Migration {}
extension MenuItem: Parameter {}


struct Items: Content {
    var items: [MenuItem]
}
