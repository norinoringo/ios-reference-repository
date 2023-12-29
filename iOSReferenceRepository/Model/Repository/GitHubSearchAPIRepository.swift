//
//  GitHubSearchAPIRepository.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/06.
//

import Foundation
import RxSwift

protocol GitHubAPIRepositoryProtocol {
    func get(type: GitHubSearchType) -> Single<Result<Data, GitHubSearchAPIError>>
}

class GitHubAPIRepository: GitHubAPIRepositoryProtocol {
    // TODO: PATHとMETHODも実装する
    private let baseURL = "https://api.github.com"

    // TODO: 各検索結果のレスポンスモデルを定義する
    func get(type: GitHubSearchType) -> Single<Result<Data, GitHubSearchAPIError>> {
        switch type {
        case let .repositories(searchText: searchText):
            return .just(getRepositories(searchText: searchText))
        case let .issues(searchText: searchText):
            return .just(getRepositories(searchText: searchText))
        case let .pullRequests(searchText: searchText):
            return .just(getRepositories(searchText: searchText))
        case let .users(searchText: searchText):
            return .just(getRepositories(searchText: searchText))
        case let .organizations(searchText: searchText):
            return .just(getRepositories(searchText: searchText))
        case let .keyword(searchText: searchText):
            return .just(getRepositories(searchText: searchText))
        }
    }

    private func getRepositories(searchText: String) -> Result<Data, GitHubSearchAPIError> {
        // TODO: 通信処理の実装
        return .success(.init())
    }
}
