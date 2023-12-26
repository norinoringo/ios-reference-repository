//
//  GitHubSearchResponse.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/25.
//  


import Foundation
// TODO: 各検索結果のレスポンスモデルを定義する
enum GitHubSearchResponse {
    case repositories(repositories: [GitHubSearchRepositoriesResponse])
    case issues(issues: [GitHubSearchRepositoriesResponse])
    case pullRequests(pullRequests: [GitHubSearchRepositoriesResponse])
    case users(users: [GitHubSearchRepositoriesResponse])
    case organizations(organizations: [GitHubSearchRepositoriesResponse])
    case keyword(keyword: [GitHubSearchRepositoriesResponse])
}
