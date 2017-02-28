import Foundation

public struct Achievement{
    public let name : String
    public let description : String
    public let imageUrl : String
}

public struct Achievements {
    public var achievements = [Achievement]()
    
    mutating func addAchivement(Name name:String, Description description:String, Image image:String)
    {
        let new = Achievement(name: name, description: description, imageUrl: image)
        self.achievements.append(new)
    }
}
