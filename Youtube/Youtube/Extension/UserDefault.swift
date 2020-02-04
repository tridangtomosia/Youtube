

import Foundation

extension UserDefaults {
    
    static func getIsLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLogin")
    }
    
    static func setIsLogin(value: Bool) {
        UserDefaults.standard.set(value, forKey: "isLogin")
    }
}
