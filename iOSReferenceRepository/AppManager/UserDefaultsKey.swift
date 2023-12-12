//
//  UserDefaultsKey.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/12.
//

import Foundation

enum UserDefaultsKey {
    case GitHubSearchHistories

    var key: String {
        switch self {
        case .GitHubSearchHistories:
            return "github_search_histories"
        }
    }
}
