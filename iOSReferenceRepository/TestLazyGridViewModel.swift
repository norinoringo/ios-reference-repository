//
//  TestLazyGridViewModel.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/21.
//  


import Foundation
import SwiftUI

class TestLazyGridViewModel: ObservableObject {
    struct GridData: Hashable {
        func hash(into hasher: inout Hasher) {
            hasher.combine(price)
            hasher.combine(isSoldOut)
        }
        let thumbImage: Image
        let price: Int
        let isSoldOut: Bool
    }

   @Published var gridData: [GridData] = []

    func fetchData() {
        gridData = createData()
    }

    private func createData() -> [GridData] {
        var data: [GridData] = []
        for i in 1 ... 30 {
            data.append(GridData(thumbImage: Image(uiImage: R.image.sarunori()!),
                                 price: i * 1000,
                                 isSoldOut: i % 2 == 0))
        }
        return data
    }
}
