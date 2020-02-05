
import UIKit
import YouTubePlayer_Swift

class TableViewCell: BaseTableViewCell {
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var nameChanelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
