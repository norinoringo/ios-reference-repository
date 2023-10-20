//
//  TestCollectionViewModel.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/16.
//  

import Foundation
import UIKit

class TestCollectionViewModel {
    struct Data {
        let thumbImgage: UIImage
        let isSoldOut: Bool
        let price: Int
    }

    var data: [Data] = []

    func fetchData() -> [Data] {
        return makeData()
    }

    private func makeData() -> [Data] {
        var data: [Data] = []

        for i in 1 ... 10 {
            data.append(Data(thumbImgage: R.image.sarunori()!,
                             isSoldOut: i % 2 == 0,
                             price: 1000 * i)
                        )
        }
        return data
    }
}
