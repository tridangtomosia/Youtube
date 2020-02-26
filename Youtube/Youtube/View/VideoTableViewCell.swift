
import UIKit
import GoogleSignIn

class VideoTableViewCell: BaseTableViewCell {
    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCoutLabel: UILabel!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var mediumImageView: UIImageView!
    @IBOutlet weak var timeHistoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            UIView.animate(withDuration: 0.5, animations: { [weak self] () in
                guard let self = self else {return}
                self.mediumImageView.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
                self.mediumImageView.shadowView(shadowOpacity: .leastNonzeroMagnitude,
                                                shadowOffset: CGSize(width: 0, height: 0),
                                                shadowRadius: .leastNonzeroMagnitude,
                                                shadowColor: UIColor.black.cgColor)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: { [weak self] () in
                guard let self = self else {return}
                self.mediumImageView.transform = CGAffineTransform.identity
                self.mediumImageView.shadowView(shadowOpacity: 10,
                                                shadowOffset: CGSize(width: 0, height: 5),
                                                shadowRadius: 5,
                                                shadowColor: UIColor.black.cgColor)
                
            })
        }
    }
    
    func setLocal(withVideo video: Video) {
        if HistoryManager.shared.getId(withId: video.identification) == true {
            nameVideoLabel.textColor = .rgb(red: 55, green: 55, blue: 55, alpha: 0.6)
        } else {
            nameVideoLabel.textColor = .black
        }
        if video.time == 0 {
            timeHistoryLabel.text = ""
        } else {
            timeHistoryLabel.text =
                "at: " + Date(timeIntervalSince1970: video.time).converseDatetoString()
        }
        nameVideoLabel.text = video.nameVideo
        nameChanelLabel.text = video.nameChanel
        viewCoutLabel.text = video.viewCount.abridgedNumber()
        mediumImageView.loadImageUrl(withUrl: video.imageMedium)
    }
}
