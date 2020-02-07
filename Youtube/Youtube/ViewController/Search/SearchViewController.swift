
import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let netWork = NetWorkLayer()
    var listVideos = [Video]()
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func getVideo(withTextResearch text: String?) {
        netWork.searchVideos(params: ["q": text ?? ""]) { (results) in
            switch results {
            case .success(let videos):
                self.listVideos = videos
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
}

extension SearchViewController: UITableViewDataSource {
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

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        getVideo(withTextResearch: inputTextField.text)
        return true
    }
}
