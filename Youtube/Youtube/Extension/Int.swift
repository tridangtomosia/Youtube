
import UIKit

extension Int {
    var scale : CGFloat {
        return CGFloat(self)*UIScreen.main.bounds.width/(CGFloat(375))
    }
}
