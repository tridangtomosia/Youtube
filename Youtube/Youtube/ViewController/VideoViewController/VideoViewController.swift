
import UIKit
import YoutubeKit
import GoogleSignIn

class VideoViewController: BaseViewController {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var playView : UIView!
    @IBOutlet weak var videoTableView: UITableView!
    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var miniView: UIView!

    private var player : YTSwiftyPlayer!
    var videos: [Video] = []
    var statistics: [StatisticRequest] = []
    var comments: [Comment] = []
    let dispatchGroup = DispatchGroup()
    var network = NetworkLayer()
    var video: Video?
    var height = CGPoint(x: 0, y: 0)
    var isComplete = false
    var beganPoint: CGPoint = .zero
    var lastPoint: CGPoint = .zero
    var playNewVideo : ((Video?)->())?
    
    var minTransatonY: CGFloat {
        return (AppDelegate.shared?.window?.bounds.height ?? 0 ) * 0.8
    }
    
    var mainBounds: CGRect {
        return AppDelegate.shared?.window?.bounds ?? .zero
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playView.addSubview(player)
        player.constraintLayout(equalToView: playView)
        avatarImageView.boundView(cornerRadius: avatarImageView.bounds.halfHeight,
                                  borderWidth: 0.5,
                                  borderColor: UIColor.rgb(red: 51, green: 51, blue: 51).cgColor,
                                  maskToBound: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.delegate = self
        videoTableView.dataSource = self
        videoTableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        videoTableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        player = YTSwiftyPlayer(playerVars: [.videoID(video?.identification ?? ""), .playsInline(true)])
        player.loadPlayer()
        addDragGesturePlayView()
        setLocal()
        requestAPI()
        playNewVideo = { (video) in
            self.video = video
            self.setLocal()
            self.view.superview?.frame = self.mainBounds
            self.videoTableView.alpha = 1
            self.titleView.alpha = 1
        }
    }
    
    func addSwipeGestureRecognizer() {
         let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(swipe:)))
         swipeUp.direction = .up
         playView.addGestureRecognizer(swipeUp)
         let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(swipe:)))
         swipeDown.direction = .down
         playView.addGestureRecognizer(swipeDown)
     }
     
     @objc func handleGesture(swipe: UISwipeGestureRecognizer) {
         if swipe.direction == .up {
             view.superview?.frame = AppDelegate.shared?.window?.frame ?? CGRect()
             player.removeFromSuperview()
             player.frame = playView.bounds
             playView.addSubview(player)
             videoTableView.alpha = 1
             titleView.alpha = 1
             let gestures = playView.gestureRecognizers
             for gesture in gestures ?? [] {
                 playView.removeGestureRecognizer(gesture)
             }
             addDragGesturePlayView()
         }
         if swipe.direction == .down {
             dismiss(animated: true)
         }
     }
    
    func addDragGesturePlayView() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dragPlayView(gesture:)))
        playView.addGestureRecognizer(gesture)
        
    }
    
    @objc func dragPlayView(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: AppDelegate.shared?.window!)
        
        switch gesture.state {
        case .began:
            print("Began")
            beganPoint = location
        case .changed:
            if lastPoint.y < location.y {
                if location.y > minTransatonY {
                    UIView.animate(withDuration: 0.5) {
                        self.view.superview?.frame = CGRect(x: 100,
                                                            y: self.mainBounds.height - 250,
                                                            width: self.mainBounds.width - 100,
                                                            height: 150)
                        self.player.frame = self.view.bounds
                    }
                    addSwipeGestureRecognizer()
                } else {
                    let distance = location.y - beganPoint.y
                    view.superview?.frame.origin.y = distance
                    view.superview?.frame.size.height = mainBounds.height - distance
                    self.titleView.alpha = 1 - location.y/300
                    self.videoTableView.alpha = 1 - location.y/300
                }
            } else {
                let distance = location.y - beganPoint.y
                view.superview?.frame.origin.y = distance
                view.superview?.frame.size.height = mainBounds.height + distance
                self.titleView.alpha = 1 - location.y/300
                self.videoTableView.alpha = 1 - location.y/300
            }
        case .ended:
            if location.y > mainBounds.halfHeight {
                UIView.animate(withDuration: 0.5) {
                    self.view.superview?.frame = CGRect(x: 100,
                                                        y: self.mainBounds.height - 250,
                                                        width: self.mainBounds.width - 100,
                                                        height: 150)
                    self.player.frame = self.view.bounds
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.superview?.frame = self.mainBounds
                    self.videoTableView.alpha = 1
                    self.titleView.alpha = 1
                }
            }
        default:
            print("Default")
        }
        lastPoint = location
    }
    
    func setLocal() {
        guard let video = video else { return }
        player.loadVideo(videoID: video.identification)
        player.autoplay = true
        avatarImageView.loadImageUrl(withUrl: video.imageMedium)
        viewCountLabel.text = video.viewCount.abridgedNumber()
        nameVideoLabel.text = video.nameVideo
        nameChanelLabel.text = video.nameChanel
    }
    
    func requestAPI() {
        guard let video = video else { return }
        if video.nameChanel == "" {
            getVideo(withNameChanel: video.nameVideo, group: dispatchGroup)
        } else {
            getVideo(withNameChanel: video.nameChanel, group: dispatchGroup)
        }
        getComments(withId: video.identification, group: dispatchGroup)
        dispatchGroup.notify(queue: .main) {
            self.videoTableView.reloadData()
        }
    }
    
    func getVideo(withNameChanel text: String?, group: DispatchGroup?) {
        group?.enter()
        self.showLoading()
        network.searchVideos(params: ["q": text ?? ""], withNumberOfFind: 10) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let videos):
                self.videos = videos
                self.getStatisics(videos: self.videos, group: group)
            case .failure(let error):
                self.alert(withTitle: "Error", withMessage: error.localizedDescription)
            }
            group?.leave()
        }
    }
    
    func getStatisics(videos: [Video], group: DispatchGroup?) {
        group?.enter()
        let arrayId = videos.map { $0.identification }
        let stringId = arrayId.comportId()
        self.network.getStatistic(params: nil, id: stringId) { [weak self] (statisticResults) in
            guard let self = self else { return }
            self.hideLoading()
            switch statisticResults {
            case .success(let statistic):
                zip(self.videos, statistic).forEach { $0.0.statistic = $0.1.statistic }
            case .failure(let error):
                self.alert(withTitle: "Error",
                           withMessage: error.localizedDescription)
            }
            group?.leave()
        }
    }
    
    func getComments(withId id: String, group: DispatchGroup?) {
        group?.enter()
        self.showLoading()
        self.network.getComment(params: ["videoId": id]) { [weak self] (results) in
            guard let self = self else { return }
            self.hideLoading()
            switch results {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                self.alert(withTitle: "warring", withMessage: error.localizedDescription)
            }
            group?.leave()
        }
    }
}

extension VideoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return Configuration.heightForCell
        } else {
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            HistoryManager.shared.saveHistory(withID: videos[indexPath.row].identification,
                                              withModel: videos[indexPath.row])
            self.player.autoplay = false
            self.player.stopVideo()
            self.video = videos[indexPath.item]
            setLocal()
        }
    }
}

extension VideoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return videos.count
        } else {
            return comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = self.videoTableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell")
                as? VideoTableViewCell {
                cell.setLocal(withVideo: videos[indexPath.row])
                return cell
            }
        } else {
            if let cell = self.videoTableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell")
                as? CommentTableViewCell{
                cell.setLocal(withComment: comments[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
}

