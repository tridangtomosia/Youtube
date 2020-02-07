
import UIKit
    
enum SelectedAcction {
    case search
    case user
}

protocol HeaderViewDelegate: class {
    func headerViewDidSelecButton(view: HeaderView, action: SelectedAcction)
}

class HeaderView: UIView {
    weak var delegate: HeaderViewDelegate?
    
    @IBAction func didTapSearch(sender: UIButton) {
        delegate?.headerViewDidSelecButton(view: self, action: .search)
    }
    @IBAction func didtapUser(sender: UIButton) {
        delegate?.headerViewDidSelecButton(view: self, action: .user)
    }
}
