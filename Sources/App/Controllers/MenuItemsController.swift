//
//  MenuItemItemsController.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Vapor
import Fluent

struct MenuItemsController: RouteCollection {
    func boot(router: Router) throws {
        
        let menuItemRoutes = router.grouped("menu")
        menuItemRoutes.get(use: getAllHandler)
        menuItemRoutes.post(MenuItem.self, use: createHandler)
        menuItemRoutes.get(MenuItem.parameter, use: getHandler)
        menuItemRoutes.put(MenuItem.parameter, use: updateHandler)
        menuItemRoutes.delete(MenuItem.parameter, use: deleteHandler)
        
        // GET http://localhost:8090/menu/entrees/ : get all menu items with category, entrees
//        menuItemRoutes.get(String.parameter, use: getCategoryMenuItemsHandler)
        
    }
    
//    func getCategoryMenuItemsHandler(_ req: Request) throws -> Future<Items> {
//        let categoryName = try req.parameters.next(String.self)
//        return try MenuItem.query(on: req).filter(\M)
//    }
//
    func getAllMenuItems(on req: Request) throws -> Future<[MenuItem]> {
        return MenuItem.query(on: req).all()
    }
    
    func getAllHandler(_ req: Request) throws -> Future<Items> {
        return try getAllMenuItems(on: req).map { menuItems in
            return Items(items: menuItems)
        }
    }
    
    func createHandler(_ req: Request, menuItem: MenuItem) throws -> Future<MenuItem> {
        return menuItem.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<MenuItem> {
        return try req.parameters.next(MenuItem.self)
    }
    
    func updateHandler(_ req: Request) throws -> Future<MenuItem> {
        return try flatMap(to: MenuItem.self, req.parameters.next(MenuItem.self), req.content.decode(MenuItem.self)) { menuItem, updatedMenuItem in
            menuItem.name = updatedMenuItem.name
            menuItem.description = updatedMenuItem.description
            menuItem.price = updatedMenuItem.price
            return menuItem.save(on: req)
        }
    }
    
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(MenuItem.self).delete(on: req).transform(to: HTTPStatus.noContent)
    }
    
}
