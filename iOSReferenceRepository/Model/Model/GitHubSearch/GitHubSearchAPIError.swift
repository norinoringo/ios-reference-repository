//
//  GitHubSearchAPIError.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/25.
//

import Foundation

enum GitHubSearchAPIError: Error {
    case notModified(info: Info) // 304
    case forbidden(info: Info) // 403
    case resourceNotFound(info: Info) // 404
    case validationFailed(info: Info) // 422
    case serviceUnavailable(info: Info) // 503

    struct Info: Codable {
        let message: String
        let errors: [Errors]?
        let documentationUrl: String

        enum CodingKeys: String, CodingKey {
            case message
            case errors
            case documentationUrl = "documentation_url"
        }

        struct Errors: Codable {
            let resource: String
            let field: String
            let code: String

            enum CodingKeys: String, CodingKey {
                case resource
                case field
                case code
            }
        }
    }
}
