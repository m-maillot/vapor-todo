import Fluent
import Vapor

/// Called before your application initializes.
func configure(_ application: Vapor.Application) {
    /// Register providers first
    application.provider(FluentProvider())

    /// Register middleware
    application.register(MiddlewareConfiguration.self, middleware)
    
    configureDatabases(application)
    
    application.register(Migrations.self, migration)
    
    registerRepositories(application)
    
    application.register(AddUserCommand.self) { container in
        return .init(userRepository: container.make())
    }
    
    application.register(extension: CommandConfiguration.self) { commands, c in
        commands.use(c.make(AddUserCommand.self), as: "addUser")
    }
    
    /// Register routes
    routes(application)
}
