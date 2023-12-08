//
//  GitHubSearchType.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/06.
//

import Foundation

enum GitHubSearchType {
    case repositories(searchText: String)
    case issues(searchText: String)
    case pullRequests(searchText: String)
    case users(searchText: String)
    case organizations(searchText: String)
    case keyword(searchText: String)
}
