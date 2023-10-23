//
//  HomeViewController.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/10/19.
//

import Foundation
import UIKit

class HomeViewController: UITabBarController {
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home画面表示")
        bind()

        homeViewDidLoad()
    }

    private func bind() {
        addObserveNotifications()
    }

    private func addObserveNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleHomeViewDidLoad),
            name: Notification.Name.Home.homeViewDidLoad,
            object: nil
        )
    }

    @objc func handleHomeViewDidLoad(_: Notification) {
        print("handleHomeViewDidLoad")
    }

    private func homeViewDidLoad() {
        viewModel.homeViewDidLoad()
    }
}
