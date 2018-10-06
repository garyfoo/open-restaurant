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
        let menuItems = data.menuIds.map { orderId in
            return MenuItem.query(on: req).filter(\.id == orderId).first().map(to: MenuItem.self) { menuItem in
                guard let menuItem = menuItem else {
                    throw Abort(.notFound)
                }
                return menuItem
            }
        }
        return menuItems.map(to: PreparationTime.self, on: req) { items in
            let waitingTimeArray = items.map { self.processOrderTime(category: $0.category) }
            let waitingTimeSum = waitingTimeArray.reduce(0, +)
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
