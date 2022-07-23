

import UIKit

class CharacterListViewController: CommonViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    var characterListViewModel = CharacterListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        titleLabel.text = "character_list".localized()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(CharacterListViewCell.self)
        
        characterListViewModel.delegate = self
        characterListViewModel.fetchData()
    }
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterListViewModel.charactersModelList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListViewCell.myClassName) as! CharacterListViewCell
        if let model = characterListViewModel.charactersModelList?[indexPath.row] {
            cell.setup(model)
        }

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension CharacterListViewController {
    func reloadList() {
        listTableView.reloadData()
    }
    
    func errorRequest() {
        //TODO: Showing popup with error
    }
}
