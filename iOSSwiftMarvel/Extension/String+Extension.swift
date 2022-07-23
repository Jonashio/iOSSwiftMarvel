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
        var myself = self
        
        if self.count > rest {
            let subtract = self.count - rest
            myself.removeLast(subtract)
        }
        
        return myself
    }
}
