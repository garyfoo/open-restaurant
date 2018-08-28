//
//  Items.swift
//  App
//
//  Created by Gary Foo on 26/8/18.
//

import Vapor

struct Items: Codable {
    var items: [MenuItem]
}

extension Items: Content {}
