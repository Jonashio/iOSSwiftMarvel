import UIKit

extension UITableView {
    func register<T: IdentifierProtocol>(_ component: T.Type) {
        let uinib = UINib(nibName: String(describing: component.self), bundle: nil)
        let idReuse = component.myClassName

        self.register(uinib, forCellReuseIdentifier: idReuse)
    }
}
