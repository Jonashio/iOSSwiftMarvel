

import UIKit

class CharacterListViewController: CommonViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    var characterListViewModel = CharacterListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "character_list".localized()
        characterListViewModel.fetchData()
    }
}
