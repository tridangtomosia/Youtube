
import UIKit

enum GradientStyle {
    case diagonalTop
    case diagonalBot
    case horizontal
    case vertical
}

extension NSObject {
    @nonobjc var className: String {
        return String(describing: type(of: self))
    }
    
    @nonobjc class var className: String {
        return String(describing: self)
    }
}

extension UIView {
    func shadowView(shadowOpacity: Float , shadowOffset: CGSize, shadowRadius: CGFloat,
                    shadowColor: CGColor) {
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor
        self.layer.masksToBounds = false
    }
    
    func boundView(cornerRadius: CGFloat, borderWidth: CGFloat , borderColor: CGColor,
                   maskToBound: Bool = true) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.layer.masksToBounds = maskToBound
    }
    
    func gradientStyle(withStyle: GradientStyle, firstColor: UIColor, endColor: UIColor) {
        switch withStyle {
        case .diagonalTop:
            gradientLayer(starPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1),
                          locations: [0,1], colors: [firstColor.cgColor, endColor.cgColor])
        case .diagonalBot:
            gradientLayer(starPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 1, y: 0),
                          locations: [0,1], colors: [firstColor.cgColor, endColor.cgColor])
        case .horizontal:
            gradientLayer(starPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0),
                          locations: [0,1], colors: [firstColor.cgColor, endColor.cgColor])
        case .vertical:
            gradientLayer(starPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1),
                          locations: [0,1], colors: [firstColor.cgColor, endColor.cgColor])
        }
    }
    
    func gradientLayer(starPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber]?,
                       colors: [CGColor]? ) {
        self.layer.sublayers?
            .filter { $0.name == "Gradient View" }
            .forEach { $0.removeFromSuperlayer() }
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = starPoint
        gradient.endPoint = endPoint
        gradient.frame = self.layer.bounds
        gradient.name = "Gradient View"
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func swapConstrain(equalToView view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
                                    self.widthAnchor.constraint(equalToConstant: view.bounds.width),
                                    self.heightAnchor.constraint(equalToConstant: view.bounds.height)])
    }
    
    func deSwapConstrain(fromView view: UIView) {
        NSLayoutConstraint.deactivate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor)])
    }
    
    class func loadView<T: UIView>(fromNib viewType: T.Type) -> T {
        let nibName = String(describing: viewType)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: self,
                                                  options: nil)?.first as? T else {
            fatalError("\(T.className) isn t exist")
        }
        return view
    }
    
    class func loadView() -> Self {
        return loadView(fromNib: self)
    }
}

