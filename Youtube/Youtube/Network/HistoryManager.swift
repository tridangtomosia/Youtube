
import Foundation
import GoogleSignIn

class History {
    static var shared = History()
    var quere = DispatchQueue(label: "History", qos: .unspecified)
    
    func saveModel(withModel model: Video, with time: String) {
        if let _ = UserDefaults.standard.data(forKey: UserID.shared.userId()) {
            model.time = time
            var newHistories = getVideos()
            for i in 0..<newHistories.count {
                if newHistories[i].id == model.id && newHistories[i].videoId?.id == model.videoId?.id {
                    newHistories[i].time = time
                }
            }
            newHistories = getVideos() + [model]
            if let data = try? PropertyListEncoder().encode(newHistories) {
                let archive = try? NSKeyedArchiver.archivedData(withRootObject: data,
                                                                requiringSecureCoding: false)
                UserDefaults.standard.set(archive, forKey: UserID.shared.userId())
            }
        } else {
            model.time = time
            if let data = try? PropertyListEncoder().encode([model]) {
                let archive = try? NSKeyedArchiver.archivedData(withRootObject: data,
                                                                requiringSecureCoding: false)
                UserDefaults.standard.set(archive, forKey: UserID.shared.userId())
            }
        }
        UserDefaults.standard.synchronize()
        
    }
    
    func getVideos() -> [Video] {
        if let data = UserDefaults.standard.data(forKey: UserID.shared.userId()) {
            if let unarchive = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data {
                let histories = try? PropertyListDecoder().decode([Video].self, from: unarchive)
                
                return histories ?? []
            }
            return []
        }
        return []
    }
    
    func saveId(withId id: String) {
        UserDefaults.standard.set(UserID.shared.userId(), forKey: id)
    }
    
    func getId(withId id:String)-> String {
        return UserDefaults.standard.string(forKey: id) ?? ""
    }
    
}
