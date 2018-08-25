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
        // GET https://localhost:8090/api/menu/: get all the menu items.
        let menuItemRoutes = router.grouped("api", "menu")
        menuItemRoutes.get(use: getAllHandler)
        menuItemRoutes.post(MenuItem.self, use: createHandler)
        menuItemRoutes.get(MenuItem.parameter, use: getHandler)
        menuItemRoutes.put(MenuItem.parameter, use: updateHandler)
        menuItemRoutes.delete(MenuItem.parameter, use: deleteHandler)
        
        menuItemRoutes.post(MenuItem.parameter, "image", Image.parameter, use: addImagesHandler)
        menuItemRoutes.get(MenuItem.parameter, "image", use: getImagesHandler)
        menuItemRoutes.delete(MenuItem.parameter, "image", Image.parameter, use: removeImagesHandler)

        menuItemRoutes.post(MenuItem.parameter, "category", Category.parameter, use: addCategoriesHandler)
        menuItemRoutes.get(MenuItem.parameter, "category", use: getCategoriesHandler)
        menuItemRoutes.delete(MenuItem.parameter, "category", Category.parameter, use: removeCategoriesHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[MenuItem]> {
        return MenuItem.query(on: req).all()
    }
    
    // POST https://localhost:8090/api/menu: create a new menu.
    func createHandler(_ req: Request, menuItem: MenuItem) throws -> Future<MenuItem> {
        return menuItem.save(on: req)
    }
    
    // GET https://localhost:8090/api/menu/1: get the menu with ID 1.
    func getHandler(_ req: Request) throws -> Future<MenuItem> {
        return try req.parameters.next(MenuItem.self)
    }
    
    // PUT https://localhost:8090/api/menu/1: update the menu with ID 1.
    func updateHandler(_ req: Request) throws -> Future<MenuItem> {
        return try flatMap(to: MenuItem.self, req.parameters.next(MenuItem.self), req.content.decode(MenuItem.self)) { menuItem, updatedMenuItem in
            menuItem.name = updatedMenuItem.name
            menuItem.description = updatedMenuItem.description
            menuItem.price = updatedMenuItem.price
            return menuItem.save(on: req)
        }
    }
    
    // DELETE https://localhost:8090/api/menu/1: delete the menu with ID 1.
    func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(MenuItem.self).delete(on: req).transform(to: HTTPStatus.noContent)
    }
    
    func addImagesHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try flatMap(to: HTTPStatus.self, req.parameters.next(MenuItem.self), req.parameters.next(Image.self)) { menuItem, image in
            return menuItem.images.attach(image, on: req).transform(to: .created)
        }
    }
    
    func getImagesHandler(_ req: Request) throws -> Future<[Image]> {
        return try req.parameters.next(MenuItem.self).flatMap(to: [Image].self) { menuItem in
            try menuItem.images.query(on: req).all()
        }
    }
    
    func removeImagesHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try flatMap(to: HTTPStatus.self, req.parameters.next(MenuItem.self), req.parameters.next(Image.self)) { menuItem, image in
            return menuItem.images.detach(image, on: req).transform(to: .noContent)
        }
    }
    
    func addCategoriesHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try flatMap(to: HTTPStatus.self, req.parameters.next(MenuItem.self), req.parameters.next(Category.self)) { menuItem, category in
            return menuItem.categories.attach(category, on: req).transform(to: .created)
        }
    }
    
    func getCategoriesHandler(_ req: Request) throws -> Future<[Category]> {
        return try req.parameters.next(MenuItem.self).flatMap(to: [Category].self) { menuItem in
            try menuItem.categories.query(on: req).all()
        }
    }
    
    func removeCategoriesHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try flatMap(to: HTTPStatus.self, req.parameters.next(MenuItem.self), req.parameters.next(Category.self)) { menuItem, category in
            return menuItem.categories.detach(category, on: req).transform(to: .noContent)
        }
    }
    
}
