//
//  TestUItableViewModel.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/12.
//  


import Foundation
import UIKit

class TestUITableViewModel {
    struct TableData {
        let thumbImage: UIImage
        let title: String
        let subTitle: String
    }

    func makeTableData() -> [TableData] {
        var tableData: [TableData] = []
        // FIXME: ここもっと良い書き方があるはず
        for _ in 1 ... 10 {
            let thumbImage = R.image.sarunori()!
            let title = String().random()
            let subTitle = String().random()
            tableData.append(TableData(thumbImage: thumbImage,
                                       title: title,
                                       subTitle: subTitle))
        }
        return tableData
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
