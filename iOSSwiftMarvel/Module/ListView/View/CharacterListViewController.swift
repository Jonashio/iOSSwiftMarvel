import UIKit

protocol CharacterListProtocol {
    func reloadList()
    func errorRequest(msg: String)
}

final class CharacterListViewController: CommonViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    internal var viewModel = CharacterListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        titleLabel.text = "character_list".localized()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(CharacterListViewCell.self)
        
        viewModel.delegate = self
        viewModel.fetchData()
    }
}

extension CharacterListViewController: CharacterListProtocol {
    func reloadList() {
        listTableView.reloadData()
    }

    func errorRequest(msg: String) {
        showAlertView(title: "Wow!", messsage: msg)
    }
}
