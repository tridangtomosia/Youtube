import UIKit

class TrendingViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    var network = NetworkLayer()
    var videos: [Video] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.gradientLayer(starPoint: CGPoint(x: 0, y: 0),
                           endPoint: CGPoint(x: 1, y: 1),
                           locations: [0,0,1,1],
                           colors: [UIColor.rgb(red: 194, green: 226, blue: 156).cgColor,
                                    UIColor.rgb(red: 100, green: 149, blue: 244).cgColor,
                                    UIColor.rgb(red: 255, green: 255, blue: 255).cgColor])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,selector: #selector(deleteHistory(_:)),
                                               name: NSNotification.Name ("remove"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerView = HeaderView.loadView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.isHidden = true
        topView.addSubview(headerView)
        headerView.constraintLayout(equalToView: topView)
        headerView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        getVideos(withRegions: "VN")
    }
    
    @objc func deleteHistory(_ notification: Notification) {
        if notification.userInfo?["Yes"] as? Bool ?? false == true {
            tableView.reloadData()
        }
    }
    
    func getVideos(withRegions region: String) {
        self.showLoading()
        self.network.getTrendVideo(params: ["regionCode": region]) { [weak self] (results) in
            guard let self = self else { return }
            self.hideLoading()
            switch results {
            case .success(let videos):
                self.videos = videos
                self.tableView.reloadData()
            case .failure(let error):
                self.alert(withTitle: "Error", withMessage: error.localizedDescription)
            }
        }
    }
}

extension TrendingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            as? TableViewCell {
            cell.setLocal(withVideo: videos[indexPath.item])
            return cell
        }
        return UITableViewCell()
    }
}

extension TrendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330.scale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goToPlayView(playWithVideo: videos[indexPath.row])
        tableView.reloadData()
    }
}

extension TrendingViewController: HeaderViewDelegate {
    func headerViewDidSelecButton(view: HeaderView, action: SelectedAcction) {
        switch action {
        case .search:
            let searchViewController = SearchViewController()
            searchViewController.modalPresentationStyle = .overFullScreen
            if self.presentedViewController != nil {
                self.presentedViewController?.present(searchViewController, animated: true)
            } else {
                present(searchViewController, animated: true)
            }
            
        default:
            let profileViewController = ProfileViewController()
            profileViewController.modalPresentationStyle = .overFullScreen
            if self.presentedViewController != nil {
                self.presentedViewController?.present(profileViewController, animated: true)
            } else {
                present(profileViewController, animated: true)
            }
        }
    }
}
