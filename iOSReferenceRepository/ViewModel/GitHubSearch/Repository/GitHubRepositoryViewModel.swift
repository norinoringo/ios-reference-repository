//
//  GitHubRepositoryViewModel.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/12/30.
//


import Foundation
import RxSwift
import RxCocoa

class GitHubRepositoryViewModel {

    let useCase: GitHubSearchUseCaseProtocol = GitHubSearchUseCase()

    private let disposeBag = DisposeBag()

    struct Input {
        let searchText: Driver<String>
    }

    struct Output {
        let repositories: Driver<GitHubSearchResponse.Repository>
        let alert: Driver<GitHubSearchAPIError>
    }

    func tranform(input: Input) -> Output {
        let alert = PublishRelay<GitHubSearchAPIError>()

        let repositories: Driver<GitHubRepository> = input.searchText
            .asObservable()
            .flatMap({ [weak self] searchText -> Observable<GitHubRepository> in
                guard let self = self else {
                    return Observable.just(GitHubRepository(items: []))
                }
                return self.useCase.search(type: .repositories(searchText: searchText))
                    .asObservable() // SingleをObserVableに変換する必要があった。SingleってObserVavble型ではないの？
                    .flatMap({ result -> Observable<GitHubRepository> in
                        switch result {
                        case .success(let response):
                            return Observable.just(response)
                        case .failure(let error):
                            alert.accept(error)
                            return Observable.empty()
                        }
                    })
            })
            .asDriver(onErrorJustReturn: (GitHubRepository(items: [])))

        repositories.drive(onNext: { _ in

        })
        .disposed(by: disposeBag)

        return Output(repositories: repositories,
                      alert: alert.asDriver(onErrorJustReturn: .unkown))
    }
}

private extension GitHubRepositoryViewModel {
    typealias GitHubRepository = GitHubSearchResponse.Repository
}
