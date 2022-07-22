//
//  CharacterListViewModel.swift
//  iOSSwiftMarvel
//
//  Created by Jonashio on 21/7/22.
//

import Foundation

class CharacterListViewModel {
    
    func fetchData() {
        CharacterListDataSource().fetchListData(params: [:]) { response in
            
        }
    }
}
