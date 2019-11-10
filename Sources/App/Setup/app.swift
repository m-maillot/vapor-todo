import Vapor

public func app(_ environment: Environment) throws -> Application {
    var environment = environment
    try LoggingSystem.bootstrap(from: &environment)
    let app = Application(environment: environment)
    configure(app)
    return app
}
