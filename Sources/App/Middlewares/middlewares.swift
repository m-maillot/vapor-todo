import Vapor

func middleware(applciation: Application) throws -> MiddlewareConfiguration {
    // Create _empty_ middleware config
    var middlewares = MiddlewareConfiguration()
    
    // Serves files from `Public/` directory
    /// middlewares.use(FileMiddleware.self)
    
    // Catches errors and converts to HTTP response
    middlewares.use(applciation.make(ErrorMiddleware.self))
    
    return middlewares
}
