//
//  GitHubSearchAPIError.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/25.
//  


import Foundation

enum GitHubSearchAPIError: Error {
    case notModified(info: ErrorInfo) // 304
    case forbidden(info: ErrorInfo) // 403
    case resourceNotFound(info: ErrorInfo) // 404
    case validationFailed(info: ErrorInfo) // 422
    case serviceUnavailable(info: ErrorInfo) // 503

    struct ErrorInfo: Codable {
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
