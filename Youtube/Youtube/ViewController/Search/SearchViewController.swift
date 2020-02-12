
import UIKit
import GoogleSignIn

class SearchViewController: BaseViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let netWork = NetWorkLayer()
    var listVideos : [Video] = []
    var listStatistic : [StatisticRequest] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
    }
    
    func getVideo(withTextResearch text: String?) {
        netWork.searchVideos(params: ["q": text ?? ""], withNumberOfFind: 30) { [weak self] (results) in
            guard let self = self else { return }
            switch results {
                case .success(let videos):
                    self.listVideos = videos
                    var arrayId : [String] = []
                    for i in videos {
                        arrayId.append(i.videoId?.id ?? "")
                    }
                    let stringId = arrayId.comportId()
                    self.netWork.getStatistic(params: nil, id: stringId) { [weak self] (statisticResults) in
                        guard let self = self else { return }
                        switch statisticResults {
                            case .success(let statistic):
                                self.listStatistic = statistic
                                self.tableView.reloadData()
                            case .failure(let error):
                                self.alert(withTitle: "Error",
                                       withMessage: error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    self.alert(withTitle: "Error", withMessage: error.localizedDescription)
                }
        }
    }
    
    @IBAction func didTapClose(sender: UIButton) {
        dismiss(animated: true) { }
    }
    @IBAction func didTapSearch(sender: UIButton) {
        view.endEditing(true)
        self.getVideo(withTextResearch: inputTextField.text)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330.scale
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
        videoViewController.setLocal(withVideo: listVideos[indexPath.row])
        videoViewController.modalPresentationStyle = .fullScreen
        present(videoViewController, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            listVideos[indexPath.row].statistic = listStatistic[indexPath.row].statistic
            cell.setLocal(withVideo: listVideos[indexPath.row])
//            UserDefaults.standard.removeObject(forKey: listVideos[indexPath.row].id)
//            UserDefaults.standard.removeObject(forKey: listVideos[indexPath.row].videoId?.id ?? "")
            return cell
        }
        return TableViewCell()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        getVideo(withTextResearch: inputTextField.text)
        return true
    }
}
