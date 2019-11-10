import Fluent
import Vapor

final class Todo: Model {
    static let schema = "todos"
    
    @ID(key: "id", generatedBy: .random)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Parent(key: "author_id")
    var author: User

    init() { }

    init(id: UUID? = UUID(), title: String, author: User) {
        self.id = id
        self.title = title
        self.$author.id = try! author.requireID()
    }
}
