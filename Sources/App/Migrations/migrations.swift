import Fluent
import Vapor

func migration(application: Application) throws -> Migrations {
    var migrations = Migrations()
    migrations.add(CreateTodoTable(), to: .psql)
    migrations.add(CreateUserTable(), to: .psql)
    migrations.add(CreateRootUser(), to: .psql)
    return migrations
}
