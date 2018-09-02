//
//  OrderController.swift
//  App
//
//  Created by Gary Foo on 27/8/18.
//

import Vapor
import Fluent

struct OrderController: RouteCollection {
    func boot(router: Router) throws {
        let orderRoute = router.grouped("order")
        orderRoute.post(Order.self, use: orderHandler)
    }
    
    func orderHandler(_ req: Request, data: Order) throws -> PreparationTime {
        let order = data
        print(order)
        let prepTime = PreparationTime(prepTime: 5)
        return prepTime
    }
    
}

struct Order: Content {
    var menuIds: [Int]
}

struct PreparationTime: Content {
    var prepTime: Int
}
