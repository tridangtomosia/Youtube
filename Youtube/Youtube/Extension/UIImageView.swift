
import UIKit

extension UIImageView {
    func load(url: String) {
        LoadImage.shared.downLoad(urlString: url) { [weak self] (image) in
            guard let self = self else { return }
            self.image = image
        }
    }
}
