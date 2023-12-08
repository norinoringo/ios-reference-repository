//
//  GitHubSearchCellData.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/06.
//

import Foundation
import UIKit

enum GitHubSearchCellData: CaseIterable {
    case repositories
    case issues
    case pullRequests
    case users
    case organizations
    case keyword

    var title: String {
        switch self {
        case .repositories:
            return " を含むリポジトリ"
        case .issues:
            return " を含むIssue"
        case .pullRequests:
            return " を含むPullRequest"
        case .users:
            return " を含む人"
        case .organizations:
            return " を含むOrganization"
        case .keyword:
            return " へ移動"
        }
    }

    var image: UIImage {
        switch self {
        default:
            return UIImage(systemName: "arrow.right") ?? UIImage()
        }
    }
}
