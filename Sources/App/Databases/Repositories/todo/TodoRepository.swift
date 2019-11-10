import Fluent
import Vapor

protocol TodoRepository {
    func find(id: UUID, on database: Database) -> EventLoopFuture<Todo?>
    func all(on database: Database) -> EventLoopFuture<[Todo]>
    func create(todo: Todo, on database: Database) -> EventLoopFuture<Todo>
    func delete(id: UUID, on database: Database) -> EventLoopFuture<Bool>
}

struct TodoRepositoryImpl: TodoRepository {
    
    func find(id: UUID, on database: Database) -> EventLoopFuture<Todo?> {
        Todo.find(id, on: database)
    }
    func all(on database: Database) -> EventLoopFuture<[Todo]> {
        Todo.query(on: database).all()
    }
    
    func create(todo: Todo, on database: Database) -> EventLoopFuture<Todo> {
        todo.create(on: database).map { todo }
    }
    
    func delete(id: UUID, on database: Database) -> EventLoopFuture<Bool> {
        Todo.find(id, on: database)
            .flatMap { todo in
                guard let todo = todo else {
                    return database.eventLoop.future(false)
                }
                return todo.delete(on: database).transform(to: true)
            }
    }
}
