//
//  GitHubSearchUseCase.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/09.
//  


import Foundation

protocol GitHubSearchUseCaseProtocol {
    func search(type: GitHubSearchType)
}

class GitHubSearchUseCase: GitHubSearchUseCaseProtocol {
    
    let repository: GitHubAPIRepositoryProtocol

    init(repository: GitHubAPIRepositoryProtocol = GitHubAPIRepository()) {
        self.repository = repository
    }

    func search(type: GitHubSearchType) {
        repository.get(type: type)
    }
}
