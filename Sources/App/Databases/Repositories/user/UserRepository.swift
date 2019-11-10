import Fluent
import Vapor

protocol UserRepository {
    func find(username: String, password: String, on request: Request?) -> EventLoopFuture<User?>
    func create(user: User) -> EventLoopFuture<User>
}

struct UserRepositoryImpl: UserRepository {
    
    var db: Database
    
    init(db: Database) {
        self.db = db
    }
    
    func find(username: String, password: String, on request: Request? = nil) -> EventLoopFuture<User?> {
        let database: Database
        if (request != nil) {
            database = db.with(request!)
        } else {
            database = db
        }
        
        return User.query(on: database)
            .filter(\User.$login == username)
            .filter(\User.$password == password)
            .first()
    }

    func create(user: User) -> EventLoopFuture<User> {
        user.create(on: db).map { user }
    }
}
