import Fluent
import Vapor

struct TodoResponse: Content {
    var id: UUID
    var title: String
    var author: String
}

extension Sequence where Element == Todo {
    func toResponse(on db: Database) -> EventLoopFuture<[TodoResponse]> {
        map { TodoResponse.from(todo: $0, on: db) }.flatten(on: db.eventLoop)
    }
}
extension TodoResponse {
    
    static func from(todo: Todo, on db: Database) -> EventLoopFuture<TodoResponse> {
        todo.$author.get(on: db).map { author in
            TodoResponse(id: try! todo.requireID(), title: todo.title, author: author.login)
        }
    }
}
