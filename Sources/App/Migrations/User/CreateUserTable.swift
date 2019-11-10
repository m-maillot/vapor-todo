import Fluent

struct CreateUserTable: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users")
            .field("id", .uuid, .identifier(auto: false))
            .field("login", .string, .required)
            .field("password", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
}
