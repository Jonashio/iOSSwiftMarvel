import UIKit

extension UILabel {
    func setupHidden() {
        let checkText = self.text ?? ""
        self.isHidden = (checkText.isEmpty) ? true : false
    }
}
