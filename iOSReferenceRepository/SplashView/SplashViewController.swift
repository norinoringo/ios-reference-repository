//
//  SplashViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/09/11.
//  

/*/
 - .xcodeファイルの修正
    - Info.plistのパス修正
    - Info.plistの"Storyboard Name"の修正
    - "UIKit Main Storyboard File Base Name"の修正
 - SplashViewの実装
    - storyboardの設定
        - Custom ClassにViewControllerを指定
        - "is Initial View Controller"にチェック
 - TopViewの実装
    - "is Initial View Controller"にチェック
    - "Embed in"からNavigation Controllerを追加
 */

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
}

extension SplashViewController {
    private func gotoTop() {
        if let nextVC = R.storyboard.top.instantiateInitialViewController() {
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
    }
}
