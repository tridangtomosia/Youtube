
import UIKit
import YouTubePlayer_Swift

class TableViewCell: BaseTableViewCell {
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var video : Video?
    
    var network = NetWorkLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    

    
    func setLocal(withVideo video: Video) {
        if video.id == "" {
            videoPlayer.loadVideoID(video.videoId?.id ?? "")
        } else {
            videoPlayer.loadVideoID(video.id)
        }
//        viewCountLabel.text = statistic.statistic?.view 
        nameVideoLabel.text = video.snippet?.title
        nameChanelLabel.text = video.snippet?.nameChannel
//        likeCountLabel.text = statistic.like
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
