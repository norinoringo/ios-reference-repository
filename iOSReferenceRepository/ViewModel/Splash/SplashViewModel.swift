//
//  SplashViewModel.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/10/13.
//

import Foundation
import RxCocoa
import RxSwift

class SplashViewModel {
    private let disposeBag = DisposeBag()

    struct Input {
        let load: Driver<Void>
    }

    struct Output {
        let presentHome: Driver<Void>
    }

    func transform(input: Input) -> Output {
        let presentHomeRelay = PublishRelay<Void>()

        input.load
            .drive(onNext: { _ in
                presentHomeRelay.accept(())
            })
            .disposed(by: disposeBag)

        return Output(presentHome: presentHomeRelay.asDriver(onErrorJustReturn: ()))
    }
}
