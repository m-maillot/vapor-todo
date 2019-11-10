import Fluent
import Vapor

func userRoutes(_ application: Application) {
    
    let userRepository = application.make(UserRepository.self)
    let userAuthentication = UserBasicAuthenticator(repository: userRepository)
    let userGroup = application.grouped("users").grouped(userAuthentication.middleware()).grouped(User.guardMiddleware())
    let userController = UserController(userRepository)
    userGroup.get("sign-in", use: userController.login)
}
