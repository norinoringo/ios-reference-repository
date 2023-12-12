//
//  GitHubSearchHisotryManagerUseCase.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/09.
//

import Foundation

protocol GitHubSearchHisotryManagerUseCaseProtocol {
    func getSearchHistories() -> [String]
    func setSearchHistory(type: GitHubSearchType) -> [String]
    func clearSearchHistory() -> [String]
}

class GitHubSearchHisotryManagerUseCase: GitHubSearchHisotryManagerUseCaseProtocol {
    let repository: UserDefaultsRepositoryProtocol

    init(repository: UserDefaultsRepositoryProtocol = UserDefaultsRepository()) {
        self.repository = repository
    }

    func getSearchHistories() -> [String] {
        guard let histories = repository.getSearchHistories() else {
            return []
        }
        return histories.reversed()
    }

    func setSearchHistory(type: GitHubSearchType) -> [String] {
        switch type {
        case let .repositories(searchText),
             let .issues(searchText),
             let .pullRequests(searchText),
             let .users(searchText),
             let .organizations(searchText),
             let .keyword(searchText):
            print("setSearchHistory(type: \(type)), searchText: \(searchText)")
            let hisotries = makeSearchHistories(searchText: searchText)
            return repository.setSearchHistories(histories: hisotries) ?? []
        }
    }

    func clearSearchHistory() -> [String] {
        repository.clearSearchHistory()
        return []
    }
}

private extension GitHubSearchHisotryManagerUseCase {
    private func makeSearchHistories(searchText: String) -> [String] {
        var histories = repository.getSearchHistories() ?? []
        // 同じ検索履歴文字は保存しない仕様
        if !histories.contains(searchText) {
            histories.append(searchText)
        }
        // 検索履歴の上限は20個の仕様
        if histories.count > 20 {
            histories.removeFirst()
        }
        return histories
    }
}
