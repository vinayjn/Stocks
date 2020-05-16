import SVProgressHUD

protocol ViewInterface: class {
    func showAlert(success: Bool, message: String) -> Void
    func showActivity() -> Void
    func hideActivity() -> Void
}

extension ViewInterface {
    func showAlert(success: Bool, message: String) -> Void {
        if success {
            SVProgressHUD.showSuccess(withStatus: message)
        } else {
            SVProgressHUD.showError(withStatus: message)
        }
    }
    
    func showActivity() -> Void {
        SVProgressHUD.show()
    }
    
    func hideActivity() -> Void {
        SVProgressHUD.dismiss()
    }
}


