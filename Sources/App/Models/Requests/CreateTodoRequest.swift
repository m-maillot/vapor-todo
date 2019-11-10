import Vapor

struct CreateTodoRequest: Content {
    var title: String
}

