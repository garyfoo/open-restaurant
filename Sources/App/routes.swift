import Vapor
import Fluent
import Routing

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let menuController = MenuController()
    
    try router.register(collection: menuController)

}
