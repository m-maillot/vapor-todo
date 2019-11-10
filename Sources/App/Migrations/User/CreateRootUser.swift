import Fluent

struct CreateRootUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        User(login: "martial", password: "password")
            .create(on: database)
            .transform(to: ())
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.eventLoop.future(())
    }
}
