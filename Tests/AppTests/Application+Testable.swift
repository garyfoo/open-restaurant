//
//  Application+Testable.swift
//  App
//
//  Created by Gary Foo on 25/8/18.
//


import Vapor
//import App
import FluentPostgreSQL

extension Application {
    
//    static func testable(envArgs: [String]? = nil) throws -> Application {
//
//        var config = Config.default()
//        var services = Services.default()
//        var env = Environment.testing
//
//        if let environmentArgs = envArgs {
//            env.arguments = environmentArgs
//        }
//
//        try App.configure(&config, &env, &services)
//        let app = try Application(config: config, environment: env, services: services)
//
//        try App.boot(app)
//        return app
//    }
    
//    static func reset() throws {
//        let revertEnvironment = ["vapor", "revert", "--all", "-y"]
//        try Application.testable(envArgs: revertEnvironment).asyncRun().wait()
//
//        let migrateEnvironment = ["vapor", "migrate", "-y"]
//        try Application.testable(envArgs: migrateEnvironment).asyncRun().wait()
//    }
//
    // Define a method that sends a request to a path and returns a Response. Allow the HTTP method and headers to be set;
    // this is for later tests. Also allow an optional, generic Content to be provided for the body.
    func sendRequest<T>(to path: String, method: HTTPMethod, headers: HTTPHeaders = .init(), body: T? = nil) throws -> Response where T: Content {
        let responder = try self.make(Responder.self)
        // Create a responder, request and wrapped request as before.
        let request = HTTPRequest(method: method, url: URL(string: path)!, headers:headers)
        let wrappedRequest = Request(http: request, using: self)
        // If the test contains a body, encode the body into the request’s content. Using Vapor’s
        // encode(_:) allows you to take advantage of any custom encoders you set.
        if let body = body {
            try wrappedRequest.content.encode(body)
        }
        // Send the request and return the response.
        return try responder.respond(to: wrappedRequest).wait()
    }
    
    // Define a convenience method that sends a request to a path without a body.
    func sendRequest(to path: String, method: HTTPMethod, headers: HTTPHeaders = .init()) throws -> Response {
        // Create an EmptyContent to satisfy the compiler for a body parameter.
        let emptyContent: EmptyContent? = nil
        // Use the method created previously to send the request.
        return try sendRequest(to: path, method: method, headers: headers, body: emptyContent)
    }
    
    // Define a method that sends a request to a path and accepts a generic Content type. This convenience
    // method allows you to send a request when you don’t care about the response.
    func sendRequest<T>(to path: String, method: HTTPMethod, headers: HTTPHeaders, data: T) throws where T: Content {
        // Use the first method created above to send the request and ignore the response.
        _ = try self.sendRequest(to: path, method: method, headers: headers, body: data)
    }
    
    // Define a generic method that accepts a Content type and Decodable type to get a response to a request.
    func getResponse<C, T>(to path: String, method: HTTPMethod = .GET, headers: HTTPHeaders = .init(), data: C? = nil, decodeTo type: T.Type) throws -> T where C: Content, T: Decodable {
        // Use the method created above to send the request.
        let response = try self.sendRequest(to: path, method: method, headers: headers, body: data)
        // Decode the response body to the generic type and return the result.
        return try response.content.decode(type).wait()
    }
    
    // Define a generic convenience method that accepts a Decodable type to get a response to a request without providing a body.
    func getResponse<T>(to path: String, method: HTTPMethod = .GET, headers: HTTPHeaders = .init(), decodeTo type: T.Type) throws -> T where T: Content {
        // Create an empty Content to satisfy the compiler.
        let emptyContent: EmptyContent? = nil
        // Use the previous method to get the response to the request.
        return try self.getResponse(to: path, method: method, headers: headers, data: emptyContent, decodeTo: type)
    }
    
}

// Defines an empty Content type to use when there's no body to send
// in a request. Since you can't define bil for a generic type, EmptyContent
// Allows you to prvide an type to satisfy the compiler.
struct EmptyContent: Content {}
