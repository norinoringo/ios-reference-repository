//
//  GitHubSearchViewModel.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/11/12.
//

import Foundation
import RxCocoa
import RxSwift

class GitHubSearchViewModel {
    let searchSuggesionsCellData = GitHubSearchSuggesionsCellData.data

    let gitHubSearchHisotryManagerUseCase: GitHubSearchHisotryManagerUseCaseProtocol
    let githubSearchUseCase: GitHubSearchUseCaseProtocol

    init(gitHubSearchHisotryManagerUseCase: GitHubSearchHisotryManagerUseCaseProtocol = GitHubSearchHisotryManagerUseCase(),
         githubSearchUseCase: GitHubSearchUseCaseProtocol = GitHubSearchUseCase())
    {
        self.gitHubSearchHisotryManagerUseCase = gitHubSearchHisotryManagerUseCase
        self.githubSearchUseCase = githubSearchUseCase
    }

    private let disposeBag = DisposeBag()

    struct Input {
        let viewWillAppear: Driver<Void>
        let searchText: Driver<String?>
        let tappedSearchHistoryButton: Driver<String>
        let tappedClearSearchHisoryButton: Driver<Void>
        let tappedSearch: Driver<GitHubSearchType>
    }

    struct Output {
        let searchKeyword: Driver<String?>
        let searchHistories: Driver<[String]>
        let screenType: Driver<GitHubSearchViewModel.screenType>
    }

    func transform(input: Input) -> Output {
        let searchKeywordRelay = PublishRelay<String?>()
        let searchHistoriesRelay = PublishRelay<[String]>()
        let screenTypeRelay = PublishRelay<GitHubSearchViewModel.screenType>()

        input.viewWillAppear
            .drive(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                let history = self.gitHubSearchHisotryManagerUseCase.getSearchHistories()
                searchHistoriesRelay.accept(history)
                history.isEmpty ? screenTypeRelay.accept(.tutorial)  : screenTypeRelay.accept(.searchHistories)
            })
            .disposed(by: disposeBag)

        input.searchText
            .drive(onNext: { [weak self] keyword in
                guard let keyword = keyword, !keyword.isEmpty else {
                    searchKeywordRelay.accept("")
                    if let self = self {
                        self.gitHubSearchHisotryManagerUseCase.getSearchHistories().isEmpty ? screenTypeRelay.accept(.tutorial) : screenTypeRelay.accept(.searchHistories)
                    }
                    return
                }
                searchKeywordRelay.accept(keyword)
                screenTypeRelay.accept(.searchConditions)
            })
            .disposed(by: disposeBag)

        input.tappedSearch
            .drive(onNext: { [weak self] searchType in
                self?.gitHubSearchHisotryManagerUseCase.addSearchHistory(type: searchType)
                searchHistoriesRelay.accept(self?.gitHubSearchHisotryManagerUseCase.getSearchHistories() ?? [])

                self?.githubSearchUseCase.search(type: searchType)
                print("githubSearchAPIRepository.get(type:\(searchType)")
            })
            .disposed(by: disposeBag)

        input.tappedClearSearchHisoryButton
            .drive(onNext: { [weak self] _ in
                let clearedHisotry = self?.gitHubSearchHisotryManagerUseCase.clearSearchHistory()
                searchHistoriesRelay.accept(clearedHisotry ?? [])
                screenTypeRelay.accept(.tutorial)
            })
            .disposed(by: disposeBag)

        return Output(searchKeyword: searchKeywordRelay.asDriver(onErrorJustReturn: nil),
                      searchHistories: searchHistoriesRelay.asDriver(onErrorJustReturn: []),
                      screenType: screenTypeRelay.asDriver(onErrorJustReturn: .none)
                      )
    }
}

extension GitHubSearchViewModel {
    enum screenType {
        case tutorial
        case searchHistories
        case searchConditions
        case none
    }
}
