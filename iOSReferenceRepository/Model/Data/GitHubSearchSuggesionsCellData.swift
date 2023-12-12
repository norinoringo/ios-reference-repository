//
//  GitHubSearchSuggesionsData.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/09.
//

import Foundation

struct GitHubSearchSuggesionsCellData {
    static let data: [GitHubSearchSuggestionModel] =
        [
            .init(type: .repositories(searchText: "")),
            .init(type: .issues(searchText: "")),
            .init(type: .pullRequests(searchText: "")),
            .init(type: .users(searchText: "")),
            .init(type: .organizations(searchText: "")),
            .init(type: .keyword(searchText: "")),
        ]
}
