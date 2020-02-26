
import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var videos: [Video] = []
    let network = NetworkLayer()
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,selector: #selector(deleteHistory(_:)),
                                               name: NSNotification.Name ("remove"), object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        let headerView = HeaderView.loadView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(headerView)
        headerView.swapConstrain(equalToView: topView)
        headerView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        getVideos()
    }
    
    @objc func deleteHistory(_ notification: Notification) {
        if notification.userInfo?["Yes"] as? Bool ?? false == true {
            tableView.reloadData()
        }
    }
    
    func getVideos() {
        showLoading()
        network.getVideos(params: ["chart" : "mostpopular"]) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading()
            switch result {
            case .success(let videos):
                self.videos = videos
                self.tableView.reloadData()
            case .failure(let error):
                self.alert(withTitle: "Error", withMessage: error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
            as? TableViewCell {
            cell.delegate = self
            cell.setLocal(withVideo: videos[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.blue
            return cell
        }
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330.scale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.goToVideoView(playWithVideo: videos[indexPath.row])
        tableView.reloadData()
    }
}

extension HomeViewController: HeaderViewDelegate {
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

extension HomeViewController: tableViewCellDelegate {
    func didTapAvatarTableViewCell(view: TableViewCell, withTapAtChanel chanel: String) {
        let searchViewController = SearchViewController()
        searchViewController.requestAPI(textSearch: chanel)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
}
