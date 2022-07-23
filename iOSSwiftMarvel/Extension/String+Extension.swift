import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }

    func removeLastIfCan(_ rest: Int) -> String {
        guard self.count > rest else {
            return self
        }

        var myself = self
        let subtract = self.count - rest

        myself.removeLast(subtract)

        return myself
    }
}
