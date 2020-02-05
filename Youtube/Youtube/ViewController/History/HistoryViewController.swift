
import UIKit

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
    }
}

extension HistoryViewController: UITableViewDelegate {
    
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            return cell
        }
        return TableViewCell()
    }
}

extension HistoryViewController: HeaderViewDelegate {
    func headerViewDidSelecButton(view: HeaderView, acction: SelectedAcction) {
        let searchViewController = SearchViewController()
        let profileViewController = ProfileViewController()
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
