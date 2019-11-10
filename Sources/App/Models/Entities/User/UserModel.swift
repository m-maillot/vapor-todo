import Fluent
import Vapor

final class User: Model {
    static let schema = "users"
    
    @ID(key: "id", generatedBy: .random)
    var id: UUID?

    @Field(key: "login")
    var login: String

    @Field(key: "password")
    var password: String
    
    @Children(for: \.$author)
    var todos: [Todo]
    
    init() { }

    init(id: UUID? = nil, login: String, password: String) {
        self.id = id
        self.login = login
        self.password = password
    }
}

extension User: Authenticatable {}
