
import UIKit
import GoogleSignIn

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCoutLabel: UILabel!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var mediumImageView: UIImageView!
    @IBOutlet weak var timeHistoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLocal(withVideo video: Video) {
        var id = ""
        if video.id == "" {
            id = video.videoId?.id ?? ""
        } else {
            id = video.id
        }
        if History.shared.getId(withId: id) == UserID.shared.userId() {
            nameVideoLabel.textColor = .yellow
        } else {
            nameVideoLabel.textColor = .black
        }
        timeHistoryLabel.text = "time" + video.time
        nameVideoLabel.text = video.snippet?.title
        nameChanelLabel.text = video.snippet?.nameChannel
        viewCoutLabel.text = video.statistic?.view
        mediumImageView?.load(url: video.snippet?.imageSizeMedium ?? "")
    }
    
}
