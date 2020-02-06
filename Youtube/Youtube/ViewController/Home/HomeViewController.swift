
import UIKit
import GoogleSignIn

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
    var playList = [Video]()
    let network = NetWorkLayer()
    var statistics = [Statistic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getVideos()
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
//        getStatistic(withId: "eVjzv0dEP0I")
    }
    
    func getVideos() {
        network.getVideos(params: ["chart" : "mostpopular"]) { (result) in
            switch result {
            case .success(let videos):
                self.playList = videos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getStatistic(withId string: String) {
        network.getStatistic(params: ["id": string]) { (results) in
            switch results {
            case .success(let videos):
                self.statistics = videos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
//            getStatistic(withId: playList[indexPath.row].id)
//            cell.viewCountLabel.text = statistics[0].statistic?.view
//            playList[indexPath.row].statistic = statistics[0]
            cell.setLocal(withVideo: playList[indexPath.row])
//            getStatistic(withId: playList[indexPath.row].videoId?.id ?? "")
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
        
    }
}

extension HomeViewController: HeaderViewDelegate {
    func headerViewDidSelecButton(view: HeaderView, acction: SelectedAcction) {
        let searchViewController = SearchViewController()
        searchViewController.modalPresentationStyle = .fullScreen
        let profileViewController = ProfileViewController()
        profileViewController.modalPresentationStyle = .fullScreen
        switch acction {
            case .search:
                present(searchViewController, animated: true) {
                    
                }
            default:
                present(profileViewController, animated: true) {
                }
        }
    }
}
