//
//  GitHubSearchAPIError.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/25.
//  


import Foundation

enum GitHubSearchAPIError: Error {
    case notModified // 304
    case forbidden // 403
    case resourceNotFound // 404
    case validationFailed // 422
    case serviceUnavailable // 503
}
