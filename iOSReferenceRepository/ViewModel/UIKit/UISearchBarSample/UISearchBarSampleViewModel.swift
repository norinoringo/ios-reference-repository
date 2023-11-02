//
//  UISearchBarSampleViewModel.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/11/02.
//  


import Foundation
import RxSwift
import RxCocoa

class UISearchBarSampleViewModel {

    struct Input {
        let viewDidAppear: Driver<Void>
        let textDidChange: Driver<String?>
        let cancelButtonClicked: Driver<Void>
        let searchButtonClicked: Driver<Void>
    }
    struct Output {
        let searchText: Driver<String?>
    }

    private var searchText: String?

    private let disposeBag = DisposeBag()

    func transform(input: Input) -> Output {
        let textRelay = PublishRelay<String?>()

        input.textDidChange
            .drive(onNext: { [weak self] text in
                print("textDidChange")
                self?.searchText = text
                textRelay.accept(text)
            })
            .disposed(by: disposeBag)

        input.cancelButtonClicked
            .drive(onNext: { _ in
                print("cancelButtonClicked")
                textRelay.accept(nil)
            })
            .disposed(by: disposeBag)

        input.searchButtonClicked
            .drive(onNext: { [weak self] _ in
                print("searchButtonClicked")
                print(self?.searchText)
            })
            .disposed(by: disposeBag)

        return Output(searchText: textRelay.asDriver(onErrorJustReturn: nil))
    }
}
