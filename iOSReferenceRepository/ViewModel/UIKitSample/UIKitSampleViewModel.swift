//
//  UIKitSampleViewModel.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/04/03.
//

import Foundation

class UIKitSampleViewModel {

    typealias items = (sections: UIkitSampleData.FrameWork, rows: [UIkitSampleData.Samples])

    var tableData = [items]()

    init() {
        // FIXME: $0.allCasesを使って簡潔に書ける気がする
        let uikitSamples = items(sections: UIkitSampleData.FrameWork.UIKit, rows: UIkitSampleData.Samples.allCases)
        tableData.append(uikitSamples)
        let rxcocoaSamples = items(sections: UIkitSampleData.FrameWork.RxCocoa, rows: [])
        tableData.append(rxcocoaSamples)
    }
}
