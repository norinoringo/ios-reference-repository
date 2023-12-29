//
//  GitHubSearchUseCaseTest.swift
//  iOSReferenceRepositoryTests
//  
//  Created by hisanori on 2023/12/25.
//  

@testable import iOSReferenceRepository
import Foundation
import RxSwift
import XCTest

class GitHubSearchUseCaseTest: XCTestCase {
    private var repository = GitHubAPIRepositoryMock()
    private var dataString = ""
    private var disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        repository = GitHubAPIRepositoryMock()
        dataString = ""
        disposeBag = DisposeBag()
    }

    func testGetGitHubSearchResponseWithRepositoryCaseSuccess() {
        dataString = GitHubSearchDataMock.repositoriesWithSuccess.dataString
        let data = Data(dataString.utf8)

        repository.getGitHubSearchResponse = { () in
            guard let response = try? JSONDecoder().decode(GitHubSearchResponse.Repository.self, from: data) else {
                fatalError("decodeエラー")
            }

            XCTAssertEqual(response.items.first?.name, "swift")
            XCTAssertEqual(response.items.first?.owner.login, "apple")
            XCTAssertEqual(response.items.first?.owner.avatarURL, "https://avatars.githubusercontent.com/u/10639145?v=4")
            XCTAssertEqual(response.items.first?.description, "The Swift Programming Language")
            XCTAssertEqual(response.items.first?.stargazersCount, 64543)
            XCTAssertEqual(response.items.first?.language, "C++")
            XCTAssertEqual(response.items.first?.htmlURL, "https://github.com/apple/swift")

            return .just(.success(Data()))
        }

        repository.get(type: .repositories(searchText: ""))
            .subscribe(onSuccess: { _ in
            })
            .disposed(by: disposeBag)
    }

    func testGetGitHubSearchResponseWithRepositoryCaseError() {
        dataString = GitHubSearchDataMock.repositoriesWithError.dataString
        let data = Data(dataString.utf8)

        repository.getGitHubSearchResponse = { () in
            guard let info = try? JSONDecoder().decode(GitHubSearchAPIError.Info.self, from: data) else {
                fatalError("decodeエラー")
            }

            XCTAssertEqual(info.message, "Validation Failed")
            XCTAssertEqual(info.errors?.first?.resource, "Search")
            XCTAssertEqual(info.errors?.first?.field, "q")
            XCTAssertEqual(info.errors?.first?.code, "missing")
            XCTAssertEqual(info.documentationUrl, "https://docs.github.com/v3/search")
            return .just(.success(Data()))
        }

        repository.get(type: .repositories(searchText: ""))
            .subscribe(onSuccess: { _ in
            })
            .disposed(by: disposeBag)
    }

    func testGetGitHubSearchResponseWithRepositoryCaseErrorWithoutErrors() {
        dataString = GitHubSearchDataMock.repositoriesWithErrorWithoutErrorsInfo.dataString
        let data = Data(dataString.utf8)

        repository.getGitHubSearchResponse = { () in
            guard let info = try? JSONDecoder().decode(GitHubSearchAPIError.Info.self, from: data) else {
                fatalError("decodeエラー")
            }

            XCTAssertEqual(info.message, "Not Found")
            XCTAssertNil(info.errors)
            XCTAssertEqual(info.documentationUrl, "https://docs.github.com/rest")
            return .just(.success(Data()))
        }

        repository.get(type: .repositories(searchText: ""))
            .subscribe(onSuccess: { _ in
            })
            .disposed(by: disposeBag)
    }
}
