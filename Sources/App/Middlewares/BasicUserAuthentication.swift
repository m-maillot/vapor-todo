import Fluent
import Vapor

class UserBasicAuthenticator: RequestAuthenticator {
    typealias User = App.User
    
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    public func authenticate(request: Request) -> EventLoopFuture<User?> {
        guard let basicAuthorization = request.headers.basicAuthorization else {
            return request.eventLoop.makeSucceededFuture(nil)
        }
        return repository.find(
            username: basicAuthorization.username,
            password: basicAuthorization.password,
            on: request
        )
    }
    
}
