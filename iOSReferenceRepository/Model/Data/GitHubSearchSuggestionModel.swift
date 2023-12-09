//
//  GitHubSearchCellData.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/06.
//

import Foundation
import UIKit

struct GitHubSearchSuggestionModel {
    var type: GitHubSearchType

    var title: String {
        switch type {
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
        switch type {
        default:
            return UIImage(systemName: "arrow.right") ?? UIImage()
        }
    }
}
