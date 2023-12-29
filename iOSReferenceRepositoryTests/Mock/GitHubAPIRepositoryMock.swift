//
//  GitHubSearchAPIRepositoryMock.swift
//  iOSReferenceRepositoryTests
//
//  Created by hisanori on 2023/12/25.
//

import Foundation
@testable import iOSReferenceRepository
import RxSwift

struct GitHubAPIRepositoryMock: GitHubAPIRepositoryProtocol {
    var getGitHubSearchResponse: () -> RxSwift.Single<Result<Data, iOSReferenceRepository.GitHubSearchAPIError>> = {
        .just(.success(.init()))
    }

    func get(type: iOSReferenceRepository.GitHubSearchType) -> RxSwift.Single<Result<Data, iOSReferenceRepository.GitHubSearchAPIError>> {
        return getGitHubSearchResponse()
    }
}
