//
//  CategoriesController.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Foundation

import Vapor

struct CategoriesController: RouteCollection {
    func boot(router: Router) throws {
        let categoriesRoute = router.grouped("api", "categories")
        categoriesRoute.post(Category.self, use: createHandler)
        categoriesRoute.get(use: getAllHandler)
        categoriesRoute.get(Category.parameter, use: getHandler)
        categoriesRoute.get(Category.parameter, "menu", use: getMenuHandler)
    }
    
    func createHandler(_ req: Request, category: Category) throws -> Future<Category> {
        return category.save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Category]> {
        return Category.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self)
    }
    
    func getMenuHandler(_ req: Request) throws -> Future<[Menu]> {
        return try req.parameters.next(Category.self).flatMap(to: [Menu].self) { category in
            try category.menus.query(on: req).all()
        }
    }
}
