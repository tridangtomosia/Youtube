
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

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

class Chanel {
    
}

class Trend {
    
}
