import Foundation

public class api42 {
    public static let shared = api42()
    public var currentUser : User?
    
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
                self.currentUser = user
                self.dataUser.addUser(User: user)
            }
        }
    }
}
