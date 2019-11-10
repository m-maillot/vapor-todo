import Fluent

struct CreateTodoTable: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todos")
            .field("id", .uuid, .identifier(auto: false))
            .field("title", .string, .required)
            .field("author_id", .uuid, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("todos").delete()
    }
}
