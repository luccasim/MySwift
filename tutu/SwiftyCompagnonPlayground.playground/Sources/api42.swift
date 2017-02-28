import Foundation

public protocol Api42Delegate: class {
    func userHandle(User user:User)
}

public class api42 {
    public static let shared = api42()
    public var currentUser : User?
    public weak var delegate : Api42Delegate?
    
    private init(){}
    private let client = HttpClient()
    private let dataUser = UserManager()
    
    public func getUsers() -> [User]
    {
        return dataUser.getData
    }
    
    public func loginRequest(Login log:String)
    {
        if let query = log.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            client.getRequest(Login: query){
                user in
                DispatchQueue.main.async {
                self.currentUser = user
                self.dataUser.addUser(User: user)
                self.delegate?.userHandle(User: user)
                }
            }
        }
    }
}
