import Foundation

public class Token {
    public var accessToken : String!
    public var tokenType : String!
    public var expires : Int!
    public var scope : String!
    public var created : Int!
    private var isSet = false

    public var valid : Bool {
        if isSet {
            let currentTimestamp = Int(Date().timeIntervalSince1970)
            let endTimestamp = created + expires
            print(endTimestamp - currentTimestamp)
            return endTimestamp - currentTimestamp > 0
        }
        return false
    }
    
    public func setToken(AccessToken token:String, Type type:String, TimeExpire timeexpire:Int, Scope scope:String, Created created:Int)
    {
        self.accessToken = token
        self.tokenType = type
        self.expires = timeexpire
        self.scope = scope
        self.created = created
        self.isSet = true
    }
}

extension Token : CustomStringConvertible {
    
    public var description: String {
        return "token = \(accessToken)" +
        "\nType = \(tokenType)" +
        "\nExpire in = \(expires)" +
        "\nScope = \(scope)" +
        "\nCreated at = \(created)"
    }
}
