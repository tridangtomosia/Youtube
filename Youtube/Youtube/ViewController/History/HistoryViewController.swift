
import UIKit
import GoogleSignIn

class HistoryViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!

    lazy var headerView : HeaderView = {
        guard let view = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView else {
            return HeaderView()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var listVideos : [Video] = []

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
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        listVideos = History.shared.getVideos()
//        UserDefaults.standard.removeObject(forKey: UserID.shared.userId())
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoViewController = VideoViewController()
        videoViewController.modalPresentationStyle = .fullScreen
        videoViewController.video = listVideos[indexPath.row]
        present(videoViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.scale
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? VideoTableViewCell {
            cell.setLocal(withVideo: listVideos[indexPath.row])
            return cell
        }
        return TableViewCell()
    }
}

extension HistoryViewController: HeaderViewDelegate {
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
