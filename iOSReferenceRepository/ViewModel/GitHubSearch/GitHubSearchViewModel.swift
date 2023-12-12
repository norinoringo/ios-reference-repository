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
    var searchHistories = [String]()

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
        let screenType: Driver<GitHubSearchViewType>
        let pushGitHubSearchResutltView: Driver<Void>
    }

    func transform(input: Input) -> Output {
        let pushGitHubSearchResutltViewRelay = PublishRelay<Void>()

        let screenTypeWithViewWillAppear: Driver<GitHubSearchViewType> = input.viewWillAppear
            .asObservable()
            .map { [weak self] _ in
                guard let self = self else {
                    return .none
                }
                self.searchHistories = self.gitHubSearchHisotryManagerUseCase.getSearchHistories()
                return self.searchHistories.isEmpty ? .tutorial : .searchHistories
            }
            .asDriver(onErrorJustReturn: GitHubSearchViewType.none)

        let screenTypeWithSearchText: Driver<GitHubSearchViewType> = input.searchText
            .asObservable()
            .map { [weak self] keyword in
                guard let self = self else {
                    return .none
                }
                guard let keyword = keyword, keyword.isEmpty else {
                    return .searchConditions
                }
                self.searchHistories = self.gitHubSearchHisotryManagerUseCase.getSearchHistories()
                return self.searchHistories.isEmpty ? .tutorial : .searchHistories
            }
            .asDriver(onErrorJustReturn: .none)

        let screenTypeWithTappedClearSearchHisoryButton: Driver<GitHubSearchViewType> = input.tappedClearSearchHisoryButton
            .asObservable()
            .map { [weak self] _ in
                guard let self = self else {
                    return .none
                }
                self.searchHistories = self.gitHubSearchHisotryManagerUseCase.clearSearchHistory()
                return .tutorial
            }
            .asDriver(onErrorJustReturn: .none)

        let screenType = Driver.merge(screenTypeWithViewWillAppear,
                                      screenTypeWithSearchText,
                                      screenTypeWithTappedClearSearchHisoryButton)

        let searchText = input.searchText
            .asObservable()
            .map { keyword in
                keyword
            }
            .asDriver(onErrorJustReturn: "")

        // TODO: input.tappedSearchとinput.tappedSearchHistoryButtonの戻り値をDriver.mergeしてOutputに渡す
        input.tappedSearch
            .drive(onNext: { [weak self] searchType in
                self?.searchHistories = self?.gitHubSearchHisotryManagerUseCase.setSearchHistory(type: searchType) ?? []

                self?.githubSearchUseCase.search(type: searchType)
                print("githubSearchAPIRepository.get(type:\(searchType)")
                pushGitHubSearchResutltViewRelay.accept(())

            })
            .disposed(by: disposeBag)

        return Output(searchKeyword: searchText,
                      screenType: screenType,
                      pushGitHubSearchResutltView: pushGitHubSearchResutltViewRelay.asDriver(onErrorJustReturn: ()))
    }
}
