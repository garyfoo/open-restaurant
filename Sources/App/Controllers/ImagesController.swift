//
//  ImagesController.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

import Vapor

struct ImagesController: RouteCollection {
    func boot(router: Router) throws {
        let imagesRoute = router.grouped("api", "images")
        imagesRoute.post(Image.self, use: createHandler)
        imagesRoute.get(use: getAllHandler)
        imagesRoute.get(Image.parameter, use: getHandler)
        imagesRoute.get(Image.parameter, "menu", use: getMenuItemsHandler)
    }
    
    func createHandler(_ req: Request, image: Image) throws -> Future<Image> {
        return image.save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Image]> {
        return Image.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<Image> {
        return try req.parameters.next(Image.self)
    }
    
    func getMenuItemsHandler(_ req: Request) throws -> Future<[MenuItem]> {
        return try req.parameters.next(Image.self).flatMap(to: [MenuItem].self) { image in
            try image.menuItems.query(on: req).all()
        }
    }
}
