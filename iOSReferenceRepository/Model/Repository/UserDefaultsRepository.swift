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
    // TODO: UserDefaultsからGET/SETする処理を追加
    private var histories = ["1", "2", "3", "4", "5"]

    func getSearchText() -> [String] {
        return histories
    }

    func addSearchText(text: String) {
        histories.append(text)
    }

    func clearSearchText() -> [String] {
        histories.removeAll()
        return histories
    }
}
