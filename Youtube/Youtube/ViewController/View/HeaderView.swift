
import UIKit
    
enum SelectedAcction {
    case search
    case user
}

protocol HeaderViewDelegate: class {
    func headerViewDidSelecButton(view: HeaderView, acction: SelectedAcction)
}

class HeaderView: UIView {
    weak var delegate: HeaderViewDelegate?
    
    @IBAction func didTapSearch(sender: UIButton) {
        delegate?.headerViewDidSelecButton(view: self, acction: .search)
    }
    @IBAction func didtapUser(sender: UIButton) {
        delegate?.headerViewDidSelecButton(view: self, acction: .user)
    }
}
