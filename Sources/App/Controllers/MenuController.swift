//
//  MenuItemsController.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Vapor
import Fluent

struct MenuController: RouteCollection {
    func boot(router: Router) throws {
        // GET https://localhost:8080/api/menu/: get all the menu items.
        let menuRoutes = router.grouped("api", "menu")
        menuRoutes.get(use: getAllHandler)
        menuRoutes.post(Menu.self, use: createHandler)
        menuRoutes.get(Menu.parameter, use: getHandler)
        menuRoutes.put(Menu.parameter, use: updateHandler)
        menuRoutes.delete(Menu.parameter, use: deleteHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Menu]> {
        return Menu.query(on: req).all()
    }
    
    // POST https://localhost:8080/api/menu: create a new menu.
    func createHandler(_ req: Request, menu: Menu) throws -> Future<Menu> {
        return menu.save(on: req)
    }
    
    // GET https://localhost:8080/api/menu/1: get the menu with ID 1.
    func getHandler(_ req: Request) throws -> Future<Menu> {
        return try req.parameters.next(Menu.self)
    }
    
    // PUT https://localhost:8080/api/menu/1: update the menu with ID 1.
    func updateHandler(_ req: Request) throws -> Future<Menu> {
        return try flatMap(to: Menu.self, req.parameters.next(Menu.self), req.content.decode(Menu.self)) { menu, updatedMenu in
            menu.name = updatedMenu.name
            menu.description = updatedMenu.description
            menu.price = updatedMenu.price
            return menu.save(on: req)
        }
    }
    
    // DELETE https://localhost:8080/api/menu/1: delete the menu with ID 1.
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Menu.self).delete(on: req).transform(to: HTTPStatus.noContent)
    }
    
}
