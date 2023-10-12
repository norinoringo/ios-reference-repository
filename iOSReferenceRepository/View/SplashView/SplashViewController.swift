//
//  SplashViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/09/11.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Splash画面表示")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gotoTop()
    }

    private func gotoTop() {
        guard let nextVC = R.storyboard.top.instantiateInitialViewController() else {
            print("Top.storyboardの取得エラー")
            return
        }
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
    }
}
