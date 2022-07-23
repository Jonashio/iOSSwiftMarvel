import UIKit
import AVFoundation
import PKHUD

protocol CommonViewProtocol {
    func startCustomActivity()
    func hiddenCustomActivity()
    func showAlertView(title : String,messsage: String)
}

class CommonViewController: UIViewController, CommonViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func startCustomActivity() {
        HUD.show(.progress)
    }

    func hiddenCustomActivity() {
        HUD.hide()
    }

    func showAlertView(title : String,messsage: String)  {
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Understood", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
