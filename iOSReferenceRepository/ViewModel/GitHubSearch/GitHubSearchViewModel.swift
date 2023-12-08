//
//  GitHubSearchViewModel.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/11/12.
//


import Foundation
import RxSwift
import RxCocoa

class GitHubSearchViewModel {
    
    let searchCellData = GitHubSearchCellData.allCases

    var userDefaultsRepository: GitHubSearchTextProtocol!
    var githubSearchAPIRepository: GitHubSearchAPIRepository!

    init(userDefaultsRepository: GitHubSearchTextProtocol = UserDefaultsRepository(),
         githubSearchAPIRepository: GitHubSearchAPIRepository = GitHubSearchAPIRepository())
    {
        self.userDefaultsRepository = userDefaultsRepository
        self.githubSearchAPIRepository = githubSearchAPIRepository
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
                searchHistoriesRelay.accept(self.userDefaultsRepository.getSearchText())
            })
            .disposed(by: disposeBag)

        input.searchText
            .drive(onNext: { keyword in
                guard let keyword = keyword, !keyword.isEmpty else {
                    searchKeywordRelay.accept("")
                    isShowTutorialRelay.accept(true)
                    isShowSearchHistoriesRelay.accept(true)
                    isShowSearchConditionsRelay.accept(false)
                    return
                }
                searchKeywordRelay.accept(keyword)
                isShowTutorialRelay.accept(false)
                isShowSearchHistoriesRelay.accept(false)
                isShowSearchConditionsRelay.accept(true)
            })
            .disposed(by: disposeBag)

        input.tappedSearch
            .drive(onNext: { [weak self] searchType in
                switch searchType {
                // TODO: APIRepositoryへのつなぎ込み
                case .repositories(searchText: let searchText):
                    self?.userDefaultsRepository.addSearchText(text: searchText)
                    print(searchText)
                case .issues(searchText: let searchText):
                    self?.userDefaultsRepository.addSearchText(text: searchText)
                    print(searchText)
                case .pullRequests(searchText: let searchText):
                    self?.userDefaultsRepository.addSearchText(text: searchText)
                    print(searchText)
                case .users(searchText: let searchText):
                    self?.userDefaultsRepository.addSearchText(text: searchText)
                    print(searchText)
                case .organizations(searchText: let searchText):
                    self?.userDefaultsRepository.addSearchText(text: searchText)
                    print(searchText)
                case .keyword(searchText: let searchText):
                    self?.userDefaultsRepository.addSearchText(text: searchText)
                    print(searchText)
                }
                let hisotry = self?.userDefaultsRepository.getSearchText()
                searchHistoriesRelay.accept(hisotry ?? [])

                self?.githubSearchAPIRepository.get(type: searchType)
                print("githubSearchAPIRepository.get(type:\(searchType)")
            })
            .disposed(by: disposeBag)

        input.tappedClearSearchHisoryButton
            .drive(onNext: { [weak self] _ in
                let history = self?.userDefaultsRepository.clearSearchText()
                searchHistoriesRelay.accept(history ?? [])
                isShowTutorialRelay.accept(true)
                isShowSearchHistoriesRelay.accept(false)
                isShowSearchConditionsRelay.accept(false)
            })
            .disposed(by: disposeBag)

        return Output(searchKeyword: searchKeywordRelay.asDriver(onErrorJustReturn: nil),
                      searchHistories: searchHistoriesRelay.asDriver(onErrorJustReturn: []),
                      isShowTutorial: isShowTutorialRelay.asDriver(onErrorJustReturn: false),
                      isShowSearchHistories: isShowSearchHistoriesRelay.asDriver(onErrorJustReturn: false),
                      isShowSearchConditions: isShowSearchConditionsRelay.asDriver(onErrorJustReturn: false)
        )
    }
}
