//
//  TopViewModel.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/03.
//  


import Foundation

class TopViewModel {
    
    struct TableData {
        enum Section: String {
            case Swift
            case RxSwift
            case UIKit
            case SwiftUI
            case RxCocoa
        }

        enum Row: String {
            // MARK: SwiftRow
            // MARK: RxSwiftRow
            // MARK: UIKitRow
            // View
            case UIScrollView
            case UITableView
            case UICollectionView
            // Component
            case UISlider

            // MARK: SwiftUIRow
            case ScrollView
            case List
            case Grid
            // MARK: RxCocoaRow
        }
    }

    typealias Data = (section: TableData.Section, rows: [TableData.Row])

    var tableData: [Data] = []

    init() {
        initTableData()
    }

    private func initTableData() {
        let swiftData: Data = (TableData.Section.Swift, [])
        let rxSwiftData: Data = (TableData.Section.RxSwift, [])

        let uikitRows: [TableData.Row] = [.UIScrollView,
                                          .UITableView,
                                          .UICollectionView,
                                          .UISlider]
        let uikitData: Data = (TableData.Section.UIKit, uikitRows)

        let swiftUIRows: [TableData.Row] = [.ScrollView,
                                            .List,
                                            .Grid]
        let swiftUIData: Data = (TableData.Section.SwiftUI, swiftUIRows)

        let rxCocoaData: Data = (TableData.Section.RxCocoa, [])

        tableData.append(swiftData)
        tableData.append(rxSwiftData)
        tableData.append(uikitData)
        tableData.append(swiftUIData)
        tableData.append(rxCocoaData)
    }
}
