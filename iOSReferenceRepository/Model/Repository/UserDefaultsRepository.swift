//
//  UserDefaultsRepository.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/05.
//

import Foundation

protocol UserDefaultsRepositoryProtocol {
    func getSearchHistories() -> [String]?
    func setSearchHistories(histories: [String]) -> [String]?
    func clearSearchHistory()
}

class UserDefaultsRepository: UserDefaultsRepositoryProtocol {

    func getSearchHistories() -> [String]? {
        return UserDefaults.standard.stringArray(forKey: UserDefaultsKey.GitHubSearchHistories.key)
    }

    func setSearchHistories(histories: [String]) -> [String]? {
        UserDefaults.standard.set(histories, forKey: UserDefaultsKey.GitHubSearchHistories.key)
        return UserDefaults.standard.stringArray(forKey: UserDefaultsKey.GitHubSearchHistories.key)
    }

    func clearSearchHistory() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.GitHubSearchHistories.key)
    }
}
