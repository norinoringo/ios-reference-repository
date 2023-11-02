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

    private let disposeBag = DisposeBag()

    func transform(input: Input) -> Output {
        let textRelay = PublishRelay<String?>()

        input.textDidChange
            .drive(onNext: { text in
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
            .drive(onNext: { _ in
                print("searchButtonClicked")
            })
            .disposed(by: disposeBag)

        return Output(searchText: textRelay.asDriver(onErrorJustReturn: nil))
    }
}
