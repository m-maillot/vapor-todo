import Fluent
import Vapor

func todoRoutes(_ application: Application) {
    
    let userRepository = application.make(UserRepository.self)
    let userAuthentication = UserBasicAuthenticator(repository: userRepository)
    let todoGroup = application.grouped("todos").grouped(userAuthentication.middleware()).grouped(User.guardMiddleware())
    let todoController = TodoController(application.make())
    todoGroup.get(use: todoController.index)
    todoGroup.post(use: todoController.create)
    todoGroup.delete(":todoID", use: todoController.delete)
}
