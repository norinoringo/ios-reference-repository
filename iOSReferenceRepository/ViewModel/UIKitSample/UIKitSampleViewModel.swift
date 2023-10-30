//
//  UIKitSampleViewModel.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/04/03.
//

import Foundation

class UIKitSampleViewModel {
    enum TableData {
        enum FrameWork: String {
            case UIKit
            case RxCocoa
        }

        enum Samples: String, CaseIterable {
            case UIScrollView
            case UITableView
            case UICollectionView
        }
    }

    typealias items = (sections: TableData.FrameWork, rows: [TableData.Samples])

    var tableData = [items]()

    init() {
        let uikitSamples = items(sections: TableData.FrameWork.UIKit, rows: TableData.Samples.allCases)
        tableData.append(uikitSamples)
        let rxcocoaSamples = items(sections: TableData.FrameWork.RxCocoa, rows: TableData.Samples.allCases)
        tableData.append(rxcocoaSamples)
    }
}
