
import UIKit

extension UIView {
    func shadowView(shadowOpacity: Float , shadowOffset: CGSize, shadowRadius: CGFloat,  shadowColor: CGColor) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor
        self.layer.masksToBounds = false
    }
    
    func boundView(cornerRadius: CGFloat, borderWidth: CGFloat , borderColor: CGColor, maskToBound: Bool) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.masksToBounds = true
    }
    
    func gradientLayer(starPoin: CGPoint, endPoint: CGPoint, withFrameView frame: CGRect , locations: [NSNumber]?, colors: [CGColor]? ) {
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = starPoin
        gradient.endPoint = endPoint
        gradient.frame = frame
        self.layer.insertSublayer(gradient, at: 0)
    }
}

