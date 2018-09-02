//
//  Catgories.swift
//  App
//
//  Created by Gary Foo on 26/8/18.
//

import Vapor

struct Categories: Codable {
    var categories: [String]
}

extension Categories: Content {}
