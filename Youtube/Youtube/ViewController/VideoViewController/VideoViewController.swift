
import UIKit
import YoutubeKit
import GoogleSignIn

public struct Configuration {
    static let heightForCell: CGFloat = 120
}

class VideoViewController: BaseViewController {
    
    @IBOutlet weak var playView : UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var video: Video?
    var network = NetWorkLayer()
    var listVideos: [Video] = []
    var listStatistics: [StatisticRequest] = []
    private var player : YTSwiftyPlayer!
//    var nextVideo : ((Video)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "VideoTableViewCell")
        setLocal(withVideo: video)
        addDragGesturePlayView()
    }
    
    func addDragGesturePlayView() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dragPlayView(gesture:)))
        playView.addGestureRecognizer(gesture)
    }
    
    @objc func dragPlayView(gesture: UIPanGestureRecognizer) {
        dismiss(animated: true)
    }

    func setLocal(withVideo video: Video?) {
        guard let video = video else { return }
        var id = ""
        if video.id == "" {
            id = video.videoId?.id ?? ""
        } else {
            id = video.id
        }
        if History.shared.getId(withId: id) == UserID.shared.userId() {
            nameVideoLabel.textColor = .yellow
        } else {
            nameVideoLabel.textColor = .black
        }
        player = YTSwiftyPlayer(playerVars: [.videoID(id), .playsInline(true)])
        playView.addSubview(player)
        NSLayoutConstraint.activate([
            player.topAnchor.constraint(equalTo: playView.topAnchor), player.bottomAnchor.constraint(equalTo: playView.bottomAnchor), player.leftAnchor.constraint(equalTo: playView.leftAnchor), player.rightAnchor.constraint(equalTo: playView.rightAnchor)])
        player.autoplay = true
        player.loadPlayer()
        avatarImageView.load(url: video.snippet?.imageSizeMedium ?? "")
        avatarImageView.boundView(cornerRadius: avatarImageView.bounds.halfHeight, borderWidth: 0.5, borderColor: UIColor.rgb(red: 51, green: 51, blue: 51).cgColor, maskToBound: true)
        viewCountLabel.text = "View :" + (video.statistic?.view ?? "")
        nameVideoLabel.text = video.snippet?.title
        nameChanelLabel.text = video.snippet?.nameChannel
        getVideo(withNameChanel: video.snippet?.nameChannel ?? "")
    }
    
    func getVideo(withNameChanel name:String) {
        network.searchVideos(params: ["id": name], withNumberOfFind: 10) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
                case .success(let videos):
                    self.listVideos = videos
                    let ids = videos.map { $0.videoId?.id ?? "" }
                    let idString = ids.comportId()
                    self.getStatistics(identification: idString)
                case .failure(let error):
                    self.alert(withTitle: "Error", withMessage: error.localizedDescription)
            }
        }
    }
    
    func getStatistics(identification: String) {
        self.network.getStatistic(params: nil, id: identification) { [weak self] (staticResults) in
            guard let self = self else { return }
            switch staticResults {
                case .success(let statistics):
                    self.listStatistics = statistics
                    self.tableView.reloadData()
                case .failure(let error):
                    self.alert(withTitle: "Error",
                           withMessage: error.localizedDescription)
            }
        }
    }
    
}

extension VideoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Configuration.heightForCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var id = ""
        if listVideos[indexPath.row].id == "" {
            id = listVideos[indexPath.row].videoId?.id ?? ""
        } else {
            id = listVideos[indexPath.row].id
        }
        History.shared.saveId(withId: id)
        let time = Date()
        History.shared.saveModel(withModel: listVideos[indexPath.row], with: time.converseDatetoString())
        self.player.autoplay = false
        self.player.stopVideo()
        setLocal(withVideo: listVideos[indexPath.row])
    }
}

extension VideoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? VideoTableViewCell {
            listVideos[indexPath.row].statistic = listStatistics[indexPath.row].statistic
            cell.setLocal(withVideo: listVideos[indexPath.row])
//            UserDefaults.standard.removeObject(forKey: listVideos[indexPath.row].id)
//            UserDefaults.standard.removeObject(forKey: listVideos[indexPath.row].videoId?.id ?? "")
            return cell
        }
        return VideoTableViewCell()
    }
    
    
}

