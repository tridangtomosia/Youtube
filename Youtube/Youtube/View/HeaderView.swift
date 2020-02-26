
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientStyle(withStyle: .vertical, firstColor: .rgb(red: 69, green: 104, blue: 220),
                           lastColor: .rgb(red: 150, green: 100, blue: 150))
    }
    
    @IBAction func didTapSearch(sender: UIButton) {
        delegate?.headerViewDidSelecButton(view: self, action: .search)
    }
    
    @IBAction func didtapUser(sender: UIButton) {
        delegate?.headerViewDidSelecButton(view: self, action: .user)
    }
}
