import Foundation
import UIKit

public class User {
    public var profile : Profile
    public var skills : SKills
    public var projects : Projects
    public var achievements : Achievements
    public var image : UIImage?
    
    init(Profile profile:Profile, Skills skills:SKills, Projects project:Projects, Achievements achievement:Achievements){
        self.achievements = achievement
        self.profile = profile
        self.projects = project
        self.skills = skills
    }
}
