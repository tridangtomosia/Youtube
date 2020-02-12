
import UIKit
import GoogleSignIn

class TableViewCell: BaseTableViewCell {
    @IBOutlet weak var nameVideoLabel: UILabel!
    @IBOutlet weak var nameChanelLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var highImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
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
        avatarImageView.load(url: video.snippet?.imageSizeMedium ?? "")
        avatarImageView.boundView(cornerRadius: avatarImageView.bounds.height/2, borderWidth: 0.5, borderColor: UIColor.rgb(red: 51, green: 51, blue: 51).cgColor, maskToBound: true)
        highImageView?.load(url: video.snippet?.imageSize?.imageSizeMedium?.urlImage ?? "")
        highImageView?.shadowView(shadowOpacity: 5, shadowOffset: CGSize(width: 10, height: 20), shadowRadius: 10, shadowColor: UIColor.blue.cgColor)
        viewCountLabel.text = "View :" + (video.statistic?.view ?? "")
        nameVideoLabel.text = video.snippet?.title
        nameChanelLabel.text = video.snippet?.nameChannel
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
