
import UIKit

class HistoryViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    var videos : [Video] = []
    
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
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        NotificationCenter.default.addObserver(self,selector: #selector(deleteHistory(_:)),
                                               name: NSNotification.Name ("remove"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let list = HistoryManager.shared.getVideos()
        videos = list.sorted { (first, second) -> Bool in
            first.time > second.time
        }
        tableView.reloadData()
    }
    
    @objc func deleteHistory(_ notification: Notification) {
        if notification.userInfo?["Yes"] as? Bool ?? false == true {
            HistoryManager.shared.removeAll()
            videos = HistoryManager.shared.getVideos()
            tableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default
            .removeObserver(self, name:  NSNotification.Name("remove"), object: nil)
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goToPlayView(playWithVideo: videos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.scale
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell")
            as? VideoTableViewCell {
            cell.setLocal(withVideo: videos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension HistoryViewController: HeaderViewDelegate {
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
