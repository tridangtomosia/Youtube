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
    
    func goToVideoView(playWithVideo video: Video) {
        dismiss(animated: true)
        HistoryManager.shared.saveHistory(withID: video.identification,
                                          withModel: video)
        let videoViewController = VideoViewController()
        videoViewController.modalPresentationStyle = .overFullScreen
        videoViewController.video = video
        present(videoViewController, animated: true)
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
