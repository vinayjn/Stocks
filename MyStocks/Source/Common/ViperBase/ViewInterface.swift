import MBProgressHUD

protocol ViewInterface: class {
  func showAlert(success: Bool, message: String) -> Void
  func showActivity() -> Void
  func hideActivity() -> Void
}

extension ViewInterface where Self: UIViewController {
  func showAlert(success: Bool, message: String) -> Void {
    let hud = MBProgressHUD(view: self.view)
    hud.label.text = message
    
    hud.show(animated: true)
  }
  
  func showActivity() -> Void {
    let hud = MBProgressHUD(view: self.view)
    hud.show(animated: true)
  }
  
  func hideActivity() -> Void {
    MBProgressHUD.hide(for: self.view, animated: true)
  }
}


