
import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var headerView : HeaderView = {
        guard let view = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?.first as? HeaderView else {
            return HeaderView()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var listVideos: [Video] = []
    let network = NetWorkLayer()
    
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
        getVideos()
    }
    
    func getVideos() {
        network.getVideos(params: ["chart" : "mostpopular"]) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                case .success(let videos):
                    self.listVideos = videos
                    self.tableView.reloadData()
                case .failure(let error):
                    self.alert(withTitle: "Error", withMessage: error.localizedDescription)
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            cell.setLocal(withVideo: listVideos[indexPath.row])
            return cell
        }
        return TableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoViewController = VideoViewController()
        videoViewController.modalPresentationStyle = .fullScreen
        videoViewController.video = listVideos[indexPath.row]
        present(videoViewController, animated: true) { }
    }
}

extension HomeViewController: HeaderViewDelegate {
    func headerViewDidSelecButton(view: HeaderView, action: SelectedAcction) {
        switch action {
            case .search:
                let searchViewController = SearchViewController()
                searchViewController.modalPresentationStyle = .fullScreen
                present(searchViewController, animated: true) { }
            default:
                let profileViewController = ProfileViewController()
                profileViewController.modalPresentationStyle = .fullScreen
                present(profileViewController, animated: true) { }
        }
    }
}
