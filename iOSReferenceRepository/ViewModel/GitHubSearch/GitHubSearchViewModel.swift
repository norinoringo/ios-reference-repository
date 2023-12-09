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
        let isShowTutorial: Driver<Bool>
        let isShowSearchHistories: Driver<Bool>
        let isShowSearchConditions: Driver<Bool>
    }

    func transform(input: Input) -> Output {
        let searchKeywordRelay = PublishRelay<String?>()
        let searchHistoriesRelay = PublishRelay<[String]>()
        let isShowTutorialRelay = PublishRelay<Bool>()
        let isShowSearchHistoriesRelay = PublishRelay<Bool>()
        let isShowSearchConditionsRelay = PublishRelay<Bool>()

        input.viewWillAppear
            .drive(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                let history = self.gitHubSearchHisotryManagerUseCase.getSearchHistories()
                searchHistoriesRelay.accept(history)
                history.isEmpty ? showTutorial() : showSearchHistories()
            })
            .disposed(by: disposeBag)

        input.searchText
            .drive(onNext: { [weak self] keyword in
                guard let keyword = keyword, !keyword.isEmpty else {
                    searchKeywordRelay.accept("")
                    if let self = self {
                        self.gitHubSearchHisotryManagerUseCase.getSearchHistories().isEmpty ? showTutorial() : showSearchHistories()
                    }
                    return
                }
                searchKeywordRelay.accept(keyword)
                showSearchConditions()
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
                showTutorial()
            })
            .disposed(by: disposeBag)

        return Output(searchKeyword: searchKeywordRelay.asDriver(onErrorJustReturn: nil),
                      searchHistories: searchHistoriesRelay.asDriver(onErrorJustReturn: []),
                      isShowTutorial: isShowTutorialRelay.asDriver(onErrorJustReturn: false),
                      isShowSearchHistories: isShowSearchHistoriesRelay.asDriver(onErrorJustReturn: false),
                      isShowSearchConditions: isShowSearchConditionsRelay.asDriver(onErrorJustReturn: false))

        func showTutorial() {
            isShowTutorialRelay.accept(true)
            isShowSearchHistoriesRelay.accept(false)
            isShowSearchConditionsRelay.accept(false)
        }

        func showSearchHistories() {
            isShowTutorialRelay.accept(false)
            isShowSearchHistoriesRelay.accept(true)
            isShowSearchConditionsRelay.accept(false)
        }

        func showSearchConditions() {
            isShowTutorialRelay.accept(false)
            isShowSearchHistoriesRelay.accept(false)
            isShowSearchConditionsRelay.accept(true)
        }
    }
}
