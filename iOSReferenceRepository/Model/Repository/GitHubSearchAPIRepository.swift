//
//  GitHubSearchAPIRepository.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/06.
//

import Foundation

// TODO: APIの実装
protocol GitHubAPIRepositoryProtocol {
    func get(type: GitHubSearchType)
}

class GitHubAPIRepository: GitHubAPIRepositoryProtocol {
    func get(type: GitHubSearchType) {
        switch type {
        case let .repositories(searchText: searchText):
            print(searchText)
        case let .issues(searchText: searchText):
            print(searchText)
        case let .pullRequests(searchText: searchText):
            print(searchText)
        case let .users(searchText: searchText):
            print(searchText)
        case let .organizations(searchText: searchText):
            print(searchText)
        case let .keyword(searchText: searchText):
            print(searchText)
        }
    }
}
