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

    let searchConditions = [String]()


    private let disposeBag = DisposeBag()

    struct Input {
        let inputtedKeywords: Driver<String?>
        let tappedClearKeywordsButton: Driver<Void>
        // 何の情報を渡すか考えないとだめ
        let tappedSearchHistoryButton: Driver<Int>
        let tappedClearSearchHisoryButton: Driver<Void>
        // 検索モデル化してもいいかも
        let tappedSearchRepositories: Driver<Void>
        let tappedSearchIssues: Driver<Void>
        let tappedSearchPullRequests: Driver<Void>
        let tappedSearchUsers: Driver<Void>
        let tappedSearchOrganizations: Driver<Void>
        let tappedSearchKeywords: Driver<Void>
    }

    struct Output {
        let searchKeyword: Driver<String?>
        // 何の情報を渡すか考えないとだめ。仮で[Stirng]
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

        input.inputtedKeywords
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

        input.tappedClearKeywordsButton
            .drive(onNext: { _ in
                searchKeywordRelay.accept(nil)
                isShowTutorialRelay.accept(true)
                isShowSearchHistoriesRelay.accept(true)
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
