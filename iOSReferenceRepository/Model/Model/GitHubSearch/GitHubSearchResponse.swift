//
//  GitHubSearchResponse.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/25.
//

import Foundation
// TODO: 各検索結果のレスポンスモデルを定義する
enum GitHubSearchResponse: Codable {
    case repositories(repositories: Repository)
    case issues(issues: Repository)
    case pullRequests(pullRequests: Repository)
    case users(users: Repository)
    case organizations(organizations: Repository)
    case keyword(keyword: Repository)

    struct Repository: Codable {
        let items: [items]

        enum CodingKeys: String, CodingKey {
            case items
        }

        struct items: Codable {
            let name: String
            let owner: Owner
            let htmlURL: String
            let description: String
            let stargazersCount: Int
            let language: String

            enum CodingKeys: String, CodingKey {
                case name
                case owner
                case htmlURL = "html_url"
                case description
                case stargazersCount = "stargazers_count"
                case language
            }
        }

        struct Owner: Codable {
            let login: String
            let avatarURL: String

            enum CodingKeys: String, CodingKey {
                case login
                case avatarURL = "avatar_url"
            }
        }
    }
}
