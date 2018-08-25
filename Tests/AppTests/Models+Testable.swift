//
//  Models+Testable.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//

//@testable import App
//import FluentPostgreSQL
//
//extension Image {
//    static func create(name: String = "Luke", imagename: String = "lukes", on connection: PostgreSQLConnection) throws -> Image {
//        let image = Image(name: name, imagename: imagename)
//        return try image.save(on: connection).wait()
//    }
//}
//
//extension Menu {
//    static func create(short: String = "TIL", long: String = "Today I Learned", image: Image? = nil, on connection: PostgreSQLConnection) throws -> Menu {
//        var menusImage = image
//        
//        if menusImage == nil {
//            menusImage = try Image.create(on: connection)
//        }
//        
//        let menu = Menu(short: short, long: long, imageID: menusImage!.id!)
//        return try menu.save(on: connection).wait()
//    }
//}
//
//extension App.Category {
//    static func create(name: String = "Random", on connection: PostgreSQLConnection) throws -> App.Category {
//        let category = Category(name: name)
//        return try category.save(on: connection).wait()
//    }
//}
