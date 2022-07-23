import Foundation

class CharacterListViewModel {

    weak var delegate: (CharacterListViewController & CommonViewProtocol)?
    var charactersModelList: [ResultModel] = []
    var offset: Int?

    func fetchData() {
        DispatchQueue.main.async { self.delegate?.startCustomActivity() }
        let nextOffset = offset ?? 0
        let params: Params = ["offset": "\(offset != nil ? nextOffset+1 : nextOffset)"]

        CharacterListDataSource().fetchListData(params: params) { response in
            switch response {
            case .success(let model):
                if let moreCharacters = model.data?.results, let newOffset = model.data?.offset, !moreCharacters.isEmpty {
                    self.charactersModelList.append(contentsOf: moreCharacters)
                    self.offset = newOffset

                    DispatchQueue.main.async { self.delegate?.reloadList() }
                }
            case .error(_):
                DispatchQueue.main.async {
                    self.delegate?.errorRequest(msg: "Error: Request CharacterListDataSource, offset(\(self.offset ?? 0)")
                }
            }
            DispatchQueue.main.async { self.delegate?.hiddenCustomActivity() }
        }
    }
}
