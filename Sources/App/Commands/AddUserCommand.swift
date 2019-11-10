import ConsoleKit
import Fluent

struct AddUserCommand: Command {
    
    struct Signature: CommandSignature {
        @Argument(name: "login", help: "User login")
        var login: String
        
        @Argument(name: "password", help: "User password")
        var password: String

        init() { }
    }

    let help = "Add a new user"
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func run(using context: CommandContext, signature: Signature) throws {
        let user = User(login: signature.$login.wrappedValue, password: signature.$password.wrappedValue)
        print(user)
        try userRepository.create(user: user)
            .map { print($0) }
            .recover { print($0) }
            .wait()
    }
}
