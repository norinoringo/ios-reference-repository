//
//  GitHubSearchHisotryManagerUseCase.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/09.
//  


import Foundation

protocol GitHubSearchHisotryManagerUseCaseProtocol {
    func getSearchHistories() -> [String]
    func addSearchHistory(type: GitHubSearchType)
    func clearSearchHistory() -> [String]
}

class GitHubSearchHisotryManagerUseCase: GitHubSearchHisotryManagerUseCaseProtocol {
    
    let repository: UserDefaultsRepositoryProtocol

    init(repository: UserDefaultsRepositoryProtocol = UserDefaultsRepository()) {
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
