import UIKit
import AVFoundation
import PKHUD

class CommonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setCustomActivity() {
        HUD.show(.progress)
    }

    func hiddenCustomActivity() {
        HUD.hide()
    }

//    func showAlertView(title : String,messsage: String)  {
//        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
//        }
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
//    }

}
