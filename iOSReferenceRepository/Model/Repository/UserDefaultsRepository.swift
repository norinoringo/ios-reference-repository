//
//  UserDefaultsRepository.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/05.
//  


import Foundation

protocol GitHubSearchTextProtocol {
    func getSearchText() -> [String]
    func addSearchText(text: String)
    func clearSearchText() -> [String]
}

class UserDefaultsRepository: GitHubSearchTextProtocol {

    func getSearchText() -> [String] {
        // TODO: UserDefaultsからGETする処理を追加
        return ["1", "2", "3", "4", "5"]
    }

    func addSearchText(text: String) {
        // TODO: UserDefaultsにSETする処理を追加
    }

    func clearSearchText() -> [String] {
        // TODO: UserDefaultsをクリアする処理を追加
        return []
    }


}
