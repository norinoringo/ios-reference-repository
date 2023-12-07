//
//  GitHubSearchAPIRepository.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/06.
//  


import Foundation

// TODO: APIの実装
protocol GitHubSearchAPIProtocol {
    func get(type: GitHubSearchType)
}

class GitHubSearchAPIRepository: GitHubSearchAPIProtocol {
    func get(type: GitHubSearchType) {
        switch type {
        case .repositories(searchText: let searchText):
            print(searchText)
        case .issues(searchText: let searchText):
            print(searchText)
        case .pullRequests(searchText: let searchText):
            print(searchText)
        case .users(searchText: let searchText):
            print(searchText)
        case .organizations(searchText: let searchText):
            print(searchText)
        case .keyword(searchText: let searchText):
            print(searchText)
        }
    }
}
