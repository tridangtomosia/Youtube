
import Foundation
import GoogleSignIn

class User {
    var name = ""
    var identification = ""
    var email = ""
    
    init(name: String, identification: String, email: String) {
        self.name = name
        self.identification = identification
        self.email = email
    }
}

class UserID {
    static var shared = UserID()
    
    func userId() -> String {
       return GIDSignIn.sharedInstance()?.currentUser.userID ?? ""
    }
}
