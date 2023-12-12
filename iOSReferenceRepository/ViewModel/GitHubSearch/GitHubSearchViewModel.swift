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
        let screenType: Driver<GitHubSearchViewModel.screenType>
        let pushGitHubSearchResutltView: Driver<Void>
    }

    func transform(input: Input) -> Output {
        let pushGitHubSearchResutltViewRelay = PublishRelay<Void>()

        let screenTypeWithViewWillAppear = input.viewWillAppear
            .asObservable()
            .map { [weak self] _ in
                guard let self = self else {
                    return GitHubSearchViewModel.screenType.none
                }
                self.searchHistories = self.gitHubSearchHisotryManagerUseCase.getSearchHistories()
                return self.searchHistories.isEmpty ? GitHubSearchViewModel.screenType.tutorial : GitHubSearchViewModel.screenType.searchHistories
            }
            .asDriver(onErrorJustReturn: GitHubSearchViewModel.screenType.none)

        let screenTypeWithSearchText = input.searchText
            .asObservable()
            .map { [weak self] keyword in
                guard let self = self else {
                    return GitHubSearchViewModel.screenType.none
                }
                guard let keyword = keyword, keyword.isEmpty else {
                    return GitHubSearchViewModel.screenType.searchConditions
                }
                self.searchHistories = self.gitHubSearchHisotryManagerUseCase.getSearchHistories()
                return self.searchHistories.isEmpty ? GitHubSearchViewModel.screenType.tutorial : GitHubSearchViewModel.screenType.searchHistories
            }
            .asDriver(onErrorJustReturn: GitHubSearchViewModel.screenType.none)

        let screenTypeWithTappedClearSearchHisoryButton = input.tappedClearSearchHisoryButton
            .asObservable()
            .map { [weak self] _ in
                guard let self = self else {
                    return GitHubSearchViewModel.screenType.none
                }
                self.searchHistories = self.gitHubSearchHisotryManagerUseCase.clearSearchHistory()
                return GitHubSearchViewModel.screenType.tutorial
            }
            .asDriver(onErrorJustReturn: GitHubSearchViewModel.screenType.none)

        let screenType = Driver.merge(screenTypeWithViewWillAppear, 
                                      screenTypeWithSearchText,
                                      screenTypeWithTappedClearSearchHisoryButton)

        let searchText = input.searchText
            .asObservable()
            .map { keyword in
                return keyword
            }
            .asDriver(onErrorJustReturn: "")


        input.tappedSearch
            .drive(onNext: { [weak self] searchType in
                self?.gitHubSearchHisotryManagerUseCase.addSearchHistory(type: searchType)
                self?.searchHistories = self?.gitHubSearchHisotryManagerUseCase.getSearchHistories() ?? []

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

extension GitHubSearchViewModel {
    enum screenType {
        case tutorial
        case searchHistories
        case searchConditions
        case none
    }
}
