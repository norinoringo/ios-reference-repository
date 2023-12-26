//
//  GitHubSearchUseCase.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/09.
//

import Foundation
import RxSwift

protocol GitHubSearchUseCaseProtocol {
    func search(type: GitHubSearchType) -> Single<Result<GitHubSearchResponse, GitHubSearchAPIError>>
}

class GitHubSearchUseCase: GitHubSearchUseCaseProtocol {
    let repository: GitHubAPIRepositoryProtocol

    init(repository: GitHubAPIRepositoryProtocol = GitHubAPIRepository()) {
        self.repository = repository
    }

    func search(type: GitHubSearchType) -> Single<Result<GitHubSearchResponse, GitHubSearchAPIError>> {
        // TODO: JSONパース処理の実装
        repository.get(type: type)
            .subscribe(onSuccess: { result in

            }, onError: { error in

            })

        return .just(.success(GitHubSearchResponse.repositories(repositories: [])))
    }
}
