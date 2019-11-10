import Fluent
import Vapor

final class UserController {
    let userRepository: UserRepository

    init(_ userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func login(req: Request) throws -> EventLoopFuture<String> {
        return req.eventLoop.future("OK")
    }
}
