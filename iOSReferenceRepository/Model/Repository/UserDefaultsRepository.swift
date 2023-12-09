//
//  UserDefaultsRepository.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/05.
//

import Foundation

protocol UserDefaultsRepositoryProtocol {
    func getSearchHistories() -> [String]
    func addSearchHistory(type: GitHubSearchType)
    func clearSearchHistory() -> [String]
}

class UserDefaultsRepository: UserDefaultsRepositoryProtocol {
    // TODO: UserDefaultsからGET/SETする処理を追加
    private var histories = ["1", "2", "3", "4", "5"]

    func getSearchHistories() -> [String] {
        getGitHubSearchHistory()
    }

    func addSearchHistory(type: GitHubSearchType) {
        switch type {
        case .repositories(let searchText):
            addGitHubSearchHistory(text: searchText)
        case .issues(let searchText):
            addGitHubSearchHistory(text: searchText)
        case .pullRequests(let searchText):
            addGitHubSearchHistory(text: searchText)
        case .users(let searchText):
            addGitHubSearchHistory(text: searchText)
        case .organizations(let searchText):
            addGitHubSearchHistory(text: searchText)
        case .keyword(let searchText):
            addGitHubSearchHistory(text: searchText)
        }
    }

    func clearSearchHistory() -> [String] {
        histories.removeAll()
        return getGitHubSearchHistory()
    }
}

private extension UserDefaultsRepository {
    private func getGitHubSearchHistory() -> [String] {
        return histories
    }

    private func addGitHubSearchHistory(text: String) {
        histories.append(text)
    }
}
