import UIKit
import GoogleSignIn

class TrendingViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    lazy var headerView : HeaderView = {
        guard let view = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView else {
            return HeaderView()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var network = NetWorkLayer()
    var listVideos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        topView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topView.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            headerView.rightAnchor.constraint(equalTo: topView.rightAnchor),
            headerView.leftAnchor.constraint(equalTo: topView.leftAnchor)])
        headerView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        getVideos(withRegions: "VN")
    }
    
    func getVideos(withRegions region: String) {
        self.network.getTrendVideo(params: ["regionCode": region]) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
                case .success(let videos):
                    self.listVideos = videos
                    self.tableView.reloadData()
                case .failure(let error):
                    self.alert(withTitle: "Error", withMessage: error.localizedDescription)
            }
        }
    }
}

extension TrendingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            cell.setLocal(withVideo: listVideos[indexPath.row])
//            UserDefaults.standard.removeObject(forKey: listVideos[indexPath.row].id)
//            UserDefaults.standard.removeObject(forKey: listVideos[indexPath.row].videoId?.id ?? "")
            return cell
        }
        return TableViewCell()
    }
}

extension TrendingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.scale
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
        let videoViewController = VideoViewController()
        videoViewController.modalPresentationStyle = .fullScreen
        videoViewController.video = listVideos[indexPath.row]
        present(videoViewController, animated: true)
    }
}

extension TrendingViewController: HeaderViewDelegate {
    func headerViewDidSelecButton(view: HeaderView, action: SelectedAcction) {
        switch action {
            case .search:
                let searchViewController = SearchViewController()
                searchViewController.modalPresentationStyle = .fullScreen
                present(searchViewController, animated: true) { }
            default:
                let profileViewController = ProfileViewController()
                profileViewController.modalPresentationStyle = .fullScreen
                present(profileViewController, animated: true) {
                }
        }
    }
}
