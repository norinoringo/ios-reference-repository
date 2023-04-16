//
//  TestListViewModel.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/15.
//  


import Foundation
import SwiftUI

class TestListViewModel: ObservableObject {

    struct ListData: Hashable {
        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(subTitle)
        }
        let thumbImage: Image
        let title: String
        let subTitle: String
    }

    @Published var fetchedData: [ListData]?
    @Published var isShowNextListView: Bool = false

    var selectedData: ListData?

    func fetchData() {
        var listData: [ListData] = []
        for _ in 1 ... 10 {
            let thumbImage = Image(uiImage:R.image.sarunori()!)
            let title = String().random()
            let subTitle = String().random()
            listData.append(ListData(thumbImage: thumbImage,
                                       title: title,
                                       subTitle: subTitle))
        }
        self.fetchedData = listData
    }

    func didTapList(selectedData: ListData) {
        self.selectedData = selectedData
        self.isShowNextListView = true
    }
}

private extension String {
    func random() -> String {
        let base = "あいうえおかきくけこさしすせそ"
        let length = Int.random(in: 0...100)
        let randomStr = String((0..<length).map { _ in
            base.randomElement()!
        })
        return randomStr
    }
}
