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
    
    func orderHandler(_ req: Request, data: Order) throws -> Future<PreparationTime> {
        let orderIds = data.menuIds
//        let waitingTime2 = orderIds.map { orderId in
//            try MenuItem.query(on: req).filter(\.id == orderId).flatMap { menuItem in
//                if let category = menuItem?.category {
//                    self.processOrderTime(category: category)
//                }
//            }
//        }
//        let test = orderIds.map { orderId in
//            return try MenuItem.query(on: req).filter(\.id == orderId).flatMap { menuItem in
//                if let category = menuItem?.category {
//                    self.processOrderTime(category: category)
//                }
//            }
//        }
        return MenuItem.query(on: req).filter(\.id ~~ orderIds).all().map { items in
            let waitingTime = items.map { self.processOrderTime(category: $0.category) }
            let waitingTimeSum = waitingTime.reduce(0, +)
            return PreparationTime(prepTime: waitingTimeSum)
        }
    }
    
    func processOrderTime(category: String) -> Int{
        switch category {
        case "appetizers":
            return 3
        case "entrees":
            return 5
        case "specials":
            return 15
        case "drinks":
            return 5
        case "desserts":
            return 5
        default:
            return 0
        }
    }
}
