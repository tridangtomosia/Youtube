
import UIKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    let netWork = NetworkLayer()
    var videos : [Video] = []
    let disPatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        addDragGestureSearchView()
    }
    
    func addDragGestureSearchView() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(dragPlayView(gesture:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func dragPlayView(gesture: UIPanGestureRecognizer) {
        dismiss(animated: true)
    }
    
    func requestAPI(textSearch: String) {
        getVideo(withTextResearch: textSearch, group: disPatchGroup)
        disPatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func getVideo(withTextResearch text: String, group : DispatchGroup) {
        self.showLoading()
        group.enter()
        netWork.searchVideos(params: ["q": text], withNumberOfFind: 30) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .success(let videos):
                self.videos = videos
                self.getStatistic(videos: videos, group: group)
            case .failure(let error):
                self.alert(withTitle: "Error", withMessage: error.localizedDescription)
                group.leave()
            }
        }
    }
    
    func getStatistic(videos: [Video], group: DispatchGroup) {
        let arrayId = videos.map{ $0.identification }
        let stringId = arrayId.comportId()
        self.netWork.getStatistic(params: nil, id: stringId) { [weak self] (statisticResults) in
            guard let self = self else { return }
            self.hideLoading()
            switch statisticResults {
            case .success(let statistic):
                zip(self.videos, statistic).forEach { $0.0.statistic = $0.1.statistic }
            case .failure(let error):
                self.alert(withTitle: "Error",
                           withMessage: error.localizedDescription)
            }
            group.leave()
        }
    }
    
    @IBAction func didTapClose(sender: UIButton) {
        dismiss(animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapSearch(sender: UIButton) {
        view.endEditing(true)
        self.requestAPI(textSearch: inputTextField.text ?? "")
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330.scale
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goToVideoView(playWithVideo: videos[indexPath.row])
    }
}

extension SearchViewController: UITableViewDataSource {
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

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        requestAPI(textSearch: self.inputTextField.text ?? "")
        return true
    }
}
