import Foundation

public class UserManager {
    private var data = [User]()
    
    public var getData : [User] {
        return data
    }
    
    func addUser(User user:User)
    {
        data.append(user)
    }
    
    subscript (index: Int) -> User
    {
        get {
            return data[index]
        }
        set {
            data.insert(newValue, at: index)
        }
    }
}
