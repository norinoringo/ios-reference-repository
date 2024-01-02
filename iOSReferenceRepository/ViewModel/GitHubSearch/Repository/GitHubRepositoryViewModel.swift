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
        let repositories: Driver<[GitHubSearchResponse.Repository]>
        let alert: Driver<GitHubSearchAPIError>
    }

    func tranform(input: Input) -> Output {
        let alert = PublishRelay<GitHubSearchAPIError>()
        let repositoryRelay = PublishRelay<[GitHubSearchResponse.Repository]>()

        input.searchText
            .asObservable()
            .subscribe(onNext: ({ [weak self] searchText in
                self?.useCase.search(type: .repositories(searchText: searchText))
                    .map({ result in
                        switch result {
                        case .success(let response):
                            if case .repositories(let repositories)  = response {
                                repositoryRelay.accept(repositories)
                            } else {
                                repositoryRelay.accept([])
                            }
                        case .failure(let error):
                            alert.accept(error)
                        }
                    })
                    .catch({ error in
                        // TODO: Result of call to 'catch' is unusedを解消する
                        fatalError()
                    })
                })
            )
            .disposed(by: disposeBag)

        return Output(repositories: repositoryRelay.asDriver(onErrorJustReturn: []),
                      alert: alert.asDriver(onErrorJustReturn: .unkown))
    }
}
