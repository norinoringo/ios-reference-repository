//
//  SplashViewController.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2022/09/11.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class SplashViewController: UIViewController {
    private let viewModel = SplashViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Splash画面表示")
        bind()
    }

    private func bind() {
        let load = rx.sentMessage(#selector(viewDidAppear(_:)))
            .asDriver(onErrorJustReturn: [])
            .map { _ in
                ()
            }

        let input = SplashViewModel.Input(load: load)
        let output = viewModel.transform(input: input)

        output.goToTop
            .drive(onNext: { [weak self] _ in
                self?.gotoTop()
            })
            .disposed(by: disposeBag)
    }

    private func gotoTop() {
        guard let nextVC = R.storyboard.top.instantiateInitialViewController() else {
            print("Top.storyboardの取得エラー")
            return
        }
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
}
