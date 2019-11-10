import Fluent
import Vapor

final class TodoController {
    let todoRepository: TodoRepository

    init(_ todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }

    func index(req: Request) throws -> EventLoopFuture<[TodoResponse]> {
        todoRepository.all(on: req.db).flatMap { $0.toResponse(on: req.db) }
    }

    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let createTodo = try req.content.decode(CreateTodoRequest.self)
        let author = try req.requireAuthenticated(User.self)
        return todoRepository
            .create(todo: Todo(title: createTodo.title, author: author), on: req.db)
            .transform(to: .created)
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let todoID = req.parameters.get("todoID"), let todoUUID = UUID(uuidString: todoID) else {
            throw Abort(HTTPStatus.badRequest)
        }
        return todoRepository.delete(id: todoUUID, on: req.db).flatMap { deleted in
                if (deleted) {
                    return req.eventLoop.future(HTTPStatus.ok)
                } else {
                    return req.eventLoop.future(error: Abort(.notFound, reason: "Todo \(todoID) not found in the database"))
                }
            }
    }
}
