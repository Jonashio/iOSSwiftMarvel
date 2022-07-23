

import UIKit

class CharacterListViewController: CommonViewController {
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!

    var viewModel = CharacterListViewModel()

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

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.charactersModelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListViewCell.myClassName) as! CharacterListViewCell
        cell.setup(viewModel.charactersModelList[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: CharactersDetailViewController.myClassName) as! CharactersDetailViewController
        
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true) {}

        vc.setup(self.viewModel.charactersModelList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row >= (viewModel.charactersModelList.count - 1) else {
            return
        }

        viewModel.fetchData()
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
