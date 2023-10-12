//
//  SplashViewModel.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/10/13.
//  

import Foundation
import RxSwift
import RxCocoa

struct SplashViewModel {

    private let disposeBag = DisposeBag()

    struct Input {
        let load: Driver<Void>
    }

    struct Output {
        let goToTop: Driver<Void>
    }

    func transform(input: Input) -> Output {
        let goToTopRelay = PublishRelay<Void>()

        input.load
            .drive(onNext: { _ in
                goToTopRelay.accept(())
            })
            .disposed(by: disposeBag)

        return Output(goToTop: goToTopRelay.asDriver(onErrorJustReturn: ()))
    }
}
