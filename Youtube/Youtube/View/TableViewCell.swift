
import UIKit
import SVProgressHUD

protocol tableViewCellDelegate: class {
    func didTapAvatarTableViewCell(view: TableViewCell, withTapAtChanel chanel: String)
}

class TableViewCell: BaseTableViewCell {
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var highImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    weak var delegate: tableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.boundView(cornerRadius: avatarImageView.bounds.height/2,
                                  borderWidth: 0.5,
                                  borderColor: UIColor.rgb(red: 51, green: 51, blue: 51).cgColor,
                                  maskToBound: true)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapgesture)
        nameVideoLabel.font = .boldSystemFont(ofSize: 16)
        highImageView.contentMode = .scaleAspectFill
        highImageView.clipsToBounds = true
    }
    
    @objc func didTapAvatar() {
        delegate?.didTapAvatarTableViewCell(view: self,
                                            withTapAtChanel: nameChanelLabel.text ?? "")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            UIView.animate(withDuration: 0.5, animations: { [weak self] () in
                guard let self = self else {return}
                self.shadowView.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
                self.shadowView.shadowView(shadowOpacity: .leastNonzeroMagnitude,
                                           shadowOffset: CGSize(width: 0, height: 0),
                                           shadowRadius: .leastNonzeroMagnitude,
                                           shadowColor: UIColor.black.cgColor)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: { [weak self] () in
                guard let self = self else {return}
                self.shadowView.transform = CGAffineTransform.identity
                self.shadowView?.shadowView(shadowOpacity: 10,
                                            shadowOffset: CGSize(width: 0, height: 5),
                                            shadowRadius: 5,
                                            shadowColor: UIColor.black.cgColor) })
        }
    }
    
    func setLocal(withVideo video: Video) {
        if HistoryManager.shared.getId(withId: video.identification) {
            nameVideoLabel.textColor = .rgb(red: 55, green: 55, blue: 55, alpha : 0.6)
        } else {
            nameVideoLabel.textColor = .black
        }
        avatarImageView.loadImageUrl(withUrl: video.imageMedium)
        highImageView.loadImageUrl(withUrl: video.imageLarge)
        viewCountLabel.text = video.viewCount.abridgedNumber()
        nameVideoLabel.text = video.nameVideo
        nameChanelLabel.text = video.nameChanel
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        SVProgressHUD.setImageViewSize(highImageView.bounds.size)
    }
}
