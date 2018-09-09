//
//  OrderController.swift
//  App
//
//  Created by Gary Foo on 27/8/18.
//

import Vapor
import Fluent
import FluentPostgreSQL

struct OrderController: RouteCollection {
    func boot(router: Router) throws {
        let orderRoute = router.grouped("order")
        orderRoute.post(Order.self, use: orderHandler)
    }
    
    func orderHandler(_ req: Request, data: Order) throws -> Future<[MenuItem]> {
        let orderIds = data.menuIds
        return MenuItem.query(on: req).filter(\.id ~~ orderIds).all().map { items in
            print(items.map { return $0.name })
            return items
        }
    }
}
