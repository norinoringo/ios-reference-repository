//
//  HomeViewModel.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/10/21.
//

import Foundation

class HomeViewModel {
    // MARK: Input

    // MARK: Output

    func homeViewDidLoad() {
        NotificationCenter.default.post(
            name: Notification.Name.Home.homeViewDidLoad,
            object: nil
        )
    }
}
