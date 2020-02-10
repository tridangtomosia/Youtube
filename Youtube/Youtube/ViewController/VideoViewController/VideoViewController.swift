
import UIKit
import YoutubePlayerView

private struct Configuration {
    static let heightForCell: CGFloat = 120
}

class VideoViewController: BaseViewController {
    
    @IBOutlet weak var videoYoutubePlayView : YoutubePlayerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var network = NetWorkLayer()
    var video: Video?
    var listVideos: [Video] = []
    var listStatistics: [StatisticRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "VideoTableViewCell")

        if let video = video {
            if video.id == "" {

                videoYoutubePlayView.loadWithVideoId(video.videoId?.id ?? "")
            } else {
                videoYoutubePlayView.loadWithVideoId(video.id)
            }
            avatarImageView.load(url: video.snippet?.imageSizeMedium ?? "")
            avatarImageView.boundView(cornerRadius: avatarImageView.bounds.halfHeight, borderWidth: 0.5, borderColor: UIColor.rgb(red: 51, green: 51, blue: 51).cgColor, maskToBound: true)
            viewCountLabel.text = "View :" + (video.statistic?.view ?? "")
            nameVideoLabel.text = video.snippet?.title
            nameChanelLabel.text = video.snippet?.nameChannel
            getVideo()
        }
    }
    
    func getVideo() {
        network.searchVideos(params: ["id": video?.snippet?.nameChannel ?? ""], withNumberOfFind: 10) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let videos):
                self.listVideos = videos
                let ids = videos.map { $0.videoId?.id ?? "" }
                let idString = ids.comportId()
                self.getStatistics(id: idString)
            case .failure(let error):
                self.alert(withTitle: "Error", withMessage: error.localizedDescription)
            }
        }
    }
    
    func getStatistics(id: String) {
        self.network.getStatistic(params: nil, id: id) { [weak self] (staticResults) in
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
}

extension VideoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? VideoTableViewCell {
            listVideos[indexPath.row].statistic = listStatistics[indexPath.row].statistic
            cell.setLocal(withVideo: listVideos[indexPath.row])
            return cell
        }
        return VideoTableViewCell()
    }
    
    
}

