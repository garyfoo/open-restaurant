import Vapor
import Fluent
import Routing

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let menuItemsController = MenuItemsController()
    let categoriesController = CategoriesController()
    let orderController = OrderController()
    
    try router.register(collection: menuItemsController)
    try router.register(collection: categoriesController)
    try router.register(collection: orderController)
}
