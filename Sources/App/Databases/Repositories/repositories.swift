import Vapor

func registerRepositories(_ application: Application) {
    
    application.register(TodoRepository.self) { container in
        TodoRepositoryImpl()
    }
    
    application.register(UserRepository.self) { container in
        UserRepositoryImpl(db: container.make())
    }
}
