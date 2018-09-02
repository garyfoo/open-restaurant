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
        orderRoute.post(use: orderHandler)
    }
    
    func orderHandler(_ req: Request) throws -> Future<HTTPStatus> {
        print(req.parameters)
        return req.future().transform(to: HTTPStatus.ok)
    }
    
}
