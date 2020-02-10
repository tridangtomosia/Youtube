
import UIKit

class TableViewCell: BaseTableViewCell {
//    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var highImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setLocal(withVideo video: Video) {
//        if video.id == "" {
//            videoPlayer.loadVideoID(video.videoId?.id ?? "")
//        } else {
//            videoPlayer.loadVideoID(video.id)
//        }
        avatarImageView.load(url: video.snippet?.imageSizeMedium ?? "")
        avatarImageView.boundView(cornerRadius: avatarImageView.bounds.height/2, borderWidth: 0.5, borderColor: UIColor.rgb(red: 51, green: 51, blue: 51).cgColor, maskToBound: true)
        highImageView?.load(url: video.snippet?.imageSize?.imageSizeMedium?.urlImage ?? "")
//        imageView?.shadowView(shadowOpacity: 5, shadowOffset: CGSize(width: 10, height: 20), shadowRadius: 10, shadowColor: UIColor.blue.cgColor)
        viewCountLabel.text = "View :" + (video.statistic?.view ?? "")
        nameVideoLabel.text = video.snippet?.title
        nameChanelLabel.text = video.snippet?.nameChannel
        
//        likeCountLabel.text = statistic.like
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
