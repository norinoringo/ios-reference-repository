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
 */

import Foundation
import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Splash画面表示")
    }
}
