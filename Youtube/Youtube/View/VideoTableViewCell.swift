
import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCoutLabel: UILabel!
    @IBOutlet weak var titleVideoLabel: UILabel!
    @IBOutlet weak var mediumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLocal(withVideo video: Video) {
        titleVideoLabel.text = video.snippet?.title
        nameChanelLabel.text = video.snippet?.nameChannel
        viewCoutLabel.text = video.statistic?.view
        mediumImageView?.load(url: video.snippet?.imageSize?.imageSizeDefault?.urlImage ?? "")
    }
    
}
