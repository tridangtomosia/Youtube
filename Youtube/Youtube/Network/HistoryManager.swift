
import Foundation
import GoogleSignIn

class HistoryManager {
    static var shared = HistoryManager()
    var quere = DispatchQueue(label: "History", qos: .unspecified)
    
    func saveModel(withModel model: Video, with time: TimeInterval) {
        if let _ = UserDefaults.standard.data(forKey: UserID.shared.id) {
            var newHistories = getVideos()
            for history in newHistories where history.identification == model.identification {
                history.time = time
                if let data = try? PropertyListEncoder().encode(newHistories) {
                    let archive = try? NSKeyedArchiver.archivedData(withRootObject: data,
                                                                    requiringSecureCoding: false)
                    UserDefaults.standard.set(archive, forKey: UserID.shared.id)
                }
                return
            }
            
            newHistories += [model]
            if let data = try? PropertyListEncoder().encode(newHistories) {
                let archive = try? NSKeyedArchiver.archivedData(withRootObject: data,
                                                                requiringSecureCoding: false)
                UserDefaults.standard.set(archive, forKey: UserID.shared.id)
            }
        } else {
            model.time = time
            if let data = try? PropertyListEncoder().encode([model]) {
                let archive = try? NSKeyedArchiver.archivedData(withRootObject: data,
                                                                requiringSecureCoding: false)
                UserDefaults.standard.set(archive, forKey: UserID.shared.id)
            }
        }
        UserDefaults.standard.synchronize()
    }
    
    func getVideos() -> [Video] {
        if let data = UserDefaults.standard.data(forKey: UserID.shared.id) {
            if let unarchive = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data {
                let histories = try? PropertyListDecoder().decode([Video].self, from: unarchive)
                return histories ?? []
            }
        }
        return []
    }
    
    func saveId(withId id: String) {
        if let dic = UserDefaults.standard.dictionary(forKey: UserID.shared.id + "last view")
            as? [String: Bool] {
            var addDic = dic
            addDic[id] = true
            UserDefaults.standard.set(addDic, forKey: UserID.shared.id + "last view")
            return
        }
        UserDefaults.standard.set([id: true], forKey: UserID.shared.id + "last view")
    }
    
    func getId(withId id:String)-> Bool {
        if let dic = UserDefaults.standard.dictionary(forKey: UserID.shared.id + "last view")
            as? [String: Bool] {
            return dic[id] ?? false
        }
        return false
    }
    
    func removeAll() {
        UserDefaults.standard.removeObject(forKey: UserID.shared.id)
        UserDefaults.standard.removeObject(forKey: UserID.shared.id + "last view")
        UserDefaults.standard.synchronize()
    }
    
    func saveHistory(withID id: String, withModel model: Video) {
        let time = Date()
        model.time =  time.timeIntervalSince1970
        saveId(withId: id)
        saveModel(withModel: model, with: time.timeIntervalSince1970)
    }
}

