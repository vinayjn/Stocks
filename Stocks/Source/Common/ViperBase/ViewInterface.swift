//import SVProgressHUD

import UIKit

public protocol ViewInterface: class {
    func showAlert(success: Bool, message: String) -> Void
    func showActivity() -> Void
    func hideActivity() -> Void
}

public extension ViewInterface where Self: UIViewController {
    func showAlert(success: Bool, message: String) -> Void {
        if success {
//            SVProgressHUD.showSuccess(withStatus: message)
        } else {
//            SVProgressHUD.showError(withStatus: message)
        }
    }
    
    func showActivity() -> Void {
//        SVProgressHUD.show()
    }
    
    func hideActivity() -> Void {
//        SVProgressHUD.dismiss()
    }
}


