import UIKit
import SVProgressHUD

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func alert(withTitle title: String, withMessage message: String ) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        alertViewController.addAction(cancelButton)
        present(alertViewController, animated: true)
    }
    
    func goToPlayView(playWithVideo video: Video) {
        HistoryManager.shared.saveHistory(withID: video.identification,
                                          withModel: video)
        if presentedViewController != nil {
            AppDelegate.shared?.videoViewController.playNewVideo?(video)
        } else {
            AppDelegate.shared?.videoViewController.video = video
            AppDelegate.shared?.videoViewController.modalPresentationStyle = .overFullScreen
            present(AppDelegate.shared?.videoViewController ?? UIViewController(), animated: true)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(.clear)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
