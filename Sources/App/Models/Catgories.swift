//
//  Catgories.swift
//  App
//
//  Created by Gary Foo on 26/8/18.
//

import Vapor

final class Categories: Codable {
    var categories: [String]
    
    init(categories: [String]) {
        self.categories = categories
    }
}

extension Categories: Content {}
