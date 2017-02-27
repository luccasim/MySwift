import Foundation

let STRERR = "@NoValue"
let INTERR = -42

public class HttpClient{
    private var token = Token()
    private let client = Client()
    
    private func getToken(Callback callback: @escaping (Token?) -> Void){
        if let url = URL(string: client.tokenUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postString = "grant_type=client_credentials&client_id=\(client.uid)&client_secret=\(client.secret)"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                if let d = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            let token = json["access_token"] as? String ?? STRERR
                            let create = json["created_at"] as? Int ?? INTERR
                            let expire = json["expires_in"] as? Int ?? INTERR
                            let scope = json["scope"] as? String ?? STRERR
                            let type = json["token_type"] as? String ?? STRERR
                            DispatchQueue.main.async {
                                self.token.setToken(AccessToken: token, Type: type, TimeExpire: expire, Scope: scope, Created: create)
                                callback(self.token)
                            }
                        }
                    }
                    catch let err {
                        print("ERROR HERE = \(err)")
                    }
                }
            }
            task.resume()
        }
    }
    
    private func loginRequest(_ log:String, Callback callback: @escaping (User)-> Void)
    {
        if let url = URL(string: client.userUrl + log){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let tokenUrl = token.accessToken!
            request.addValue("Bearer \(tokenUrl)", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request){
                data, response, error in
                    if let d = data {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                                let firstName = json["first_name"] as? String ?? STRERR
//                                let lastName = json["last_name"] as? String ?? STRERR
//                                let phone = json["phone"] as? String ?? STRERR
//                                let mail = json["mail"] as? String ?? STRERR
//                                let wallet = json["wallet"] as? Int ?? INTERR
//                                let img = json["image_url"] as? String ?? STRERR
                                print(json)
                            }
                        }
                        catch let err {
                            print(err)
                        }
                    }
                }
            task.resume()
        }
    }
    
    public func getRequest(Login log:String, Callback callback: @escaping (User)-> Void)
    {
        if token.valid {
            print("VALID TOKEN")
            loginRequest(log, Callback: callback)
        }
        else {
            print("UNVALID TOKEN")
            getToken() {
                token in
                if token != nil {
                    self.getRequest(Login: log, Callback: callback)
                }
            }
        }
    }
}
