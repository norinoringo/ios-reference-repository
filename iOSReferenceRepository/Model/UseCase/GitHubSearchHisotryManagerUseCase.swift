//
//  GitHubSearchHisotryManagerUseCase.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/09.
//  


import Foundation

protocol GitHubSearchHisotryManagerProtocol {
    func getSearchHistories() -> [String]
    func addSearchHistory(type: GitHubSearchType)
    func clearSearchHistory() -> [String]
}

class GitHubSearchHisotryManagerUseCase: GitHubSearchHisotryManagerProtocol {
    
    let repository: GitHubSearchHistoryProtocol

    init(repository: GitHubSearchHistoryProtocol = UserDefaultsRepository()) {
        self.repository = repository
    }


    func getSearchHistories() -> [String] {
        return repository.getSearchHistories()
    }

    func addSearchHistory(type: GitHubSearchType) {
        repository.addSearchHistory(type: type)
    }

    func clearSearchHistory() -> [String] {
        return repository.clearSearchHistory()
    }
}
