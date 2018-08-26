//
//  Items.swift
//  App
//
//  Created by Gary Foo on 26/8/18.
//

import Vapor

final class Items: Codable {
    var items: [MenuItem]
    
    init(items: [MenuItem]) {
        self.items = items
    }
}

extension Items: Content {}
