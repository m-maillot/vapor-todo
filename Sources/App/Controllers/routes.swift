import Fluent
import Vapor

func routes(_ application: Application) {
    application.get { req in
        "It works!"
    }

    userRoutes(application)
    
    todoRoutes(application)
}
