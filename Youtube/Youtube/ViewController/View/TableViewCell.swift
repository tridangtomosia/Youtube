
import UIKit
import YouTubePlayer_Swift

class TableViewCell: BaseTableViewCell {
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var nameChanelLabel: UILabel!
    var video: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        videoPlayer.loadVideoID(video ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
