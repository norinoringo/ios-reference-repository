//
//  GitHubSearchUseCase.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/09.
//

import Foundation
import RxSwift

protocol GitHubSearchUseCaseProtocol {
    func search(type: GitHubSearchType) -> Single<Result<GitHubSearchResponse.Repository, GitHubSearchAPIError>>
}

class GitHubSearchUseCase: GitHubSearchUseCaseProtocol {
    let repository: GitHubAPIRepositoryProtocol

    init(repository: GitHubAPIRepositoryProtocol = GitHubAPIRepository()) {
        self.repository = repository
    }

    func search(type: GitHubSearchType) -> Single<Result<GitHubSearchResponse.Repository, GitHubSearchAPIError>> {
        return repository.get(type: type)
            .map { result -> Result<GitHubSearchResponse.Repository, GitHubSearchAPIError> in
                    switch result {
                    case .success(let data):
                        do {
                            let response = try JSONDecoder().decode(GitHubSearchResponse.Repository.self, from: data)
                            return .success(response)
                        } catch {
                            fatalError()
                        }
                    case .failure(let error):
                        return .failure(.unkown)
                    }
                }
    }
}
