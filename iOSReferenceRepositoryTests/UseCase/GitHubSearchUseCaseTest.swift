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
    private let disposeBag = DisposeBag()

    func testGetGitHubSearchResponseWithRepositoryCaseSuccess() {
        var repository = GitHubAPIRepositoryMock()
        let dataString = GitHubSearchDataMock.repositories.dataString
        let data = Data(dataString.utf8)

        repository.getGitHubSearchResponse = { () in

            guard let response = try? JSONDecoder().decode(GitHubSearchRepositoriesResponse.self, from: data) else {
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
}
