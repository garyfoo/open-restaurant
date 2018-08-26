//
//  CategoriesController.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Vapor

struct CategoriesController: RouteCollection {
    func boot(router: Router) throws {
        let categoriesRoute = router.grouped("api", "categories")
        categoriesRoute.post(Category.self, use: createHandler)
        categoriesRoute.get(use: getAllHandler)
        categoriesRoute.get(Category.parameter, use: getHandler)
        categoriesRoute.get(Category.parameter, "menu", use: getMenuItemsHandler)
    }
    
    func createHandler(_ req: Request, category: Category) throws -> Future<Category> {
        return category.save(on: req)
    }
    
    func getAllCategories(on req: Request) -> Future<[Category]> {
        return Category.query(on: req).all()
    }

    func getAllHandler(_ req: Request) throws -> Future<Categories> {
        return getAllCategories(on: req).map { categories in
            let categoryNames = categories.map { $0.name }
            return Categories(categories: categoryNames)
        }
    }
    
    func getHandler(_ req: Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self)
    }
    
    func getMenuItemsHandler(_ req: Request) throws -> Future<[MenuItem]> {
        return try req.parameters.next(Category.self).flatMap(to: [MenuItem].self) { category in
            try category.menuItems.query(on: req).all()
        }
    }
}
