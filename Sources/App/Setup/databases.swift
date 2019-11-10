import Fluent
import FluentPostgresDriver
import Vapor

func configureDatabases(_ application: Vapor.Application) {
    application.databases.postgres(
        configuration: .init(hostname: "localhost", port: 5432, username: "postgres", password: "", database: "todos"),
        poolConfiguration: application.make(),
        on: application.make()
    )
}
