//
//  CharacterListViewModel.swift
//  iOSSwiftMarvel
//
//  Created by Jonashio on 21/7/22.
//

import Foundation

class CharacterListViewModel {

    weak var delegate: CharacterListViewController?
    var charactersModelList: [ResultModel]?

    func fetchData() {
        CharacterListDataSource().fetchListData(params: [:]) { response in
            switch response {
            case .success(let model):
                self.charactersModelList = model.data?.results
                DispatchQueue.main.async { self.delegate?.reloadList() }
            case .error(let error):
                DispatchQueue.main.async { self.delegate?.errorRequest() }
            }
        }
    }
}
