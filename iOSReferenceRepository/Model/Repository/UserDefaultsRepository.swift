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
        case let .repositories(searchText):
            addGitHubSearchHistory(text: searchText)
        case let .issues(searchText):
            addGitHubSearchHistory(text: searchText)
        case let .pullRequests(searchText):
            addGitHubSearchHistory(text: searchText)
        case let .users(searchText):
            addGitHubSearchHistory(text: searchText)
        case let .organizations(searchText):
            addGitHubSearchHistory(text: searchText)
        case let .keyword(searchText):
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
