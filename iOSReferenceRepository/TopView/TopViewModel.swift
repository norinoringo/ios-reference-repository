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

        enum SwiftRow: CaseIterable {

        }

        enum RxSwiftRow: CaseIterable {

        }

        enum UIKitRow: CaseIterable {
            // View
            case UIScrollView
            case UITableView
            case UICollectionView
            // Component
            case UISlider
        }

        enum SwiftUIRow: CaseIterable {

        }

        enum RxCocoaRow: CaseIterable {

        }
    }

    typealias Data = (section: TableData.Section, rows: [String])

    var tableData: [Data] = []



    init() {
        initTableData()
    }

    private func initTableData() {
        let swiftData: Data = (TableData.Section.Swift, TableData.SwiftRow.allCases.map { "\($0)" })
        let rxSwiftData: Data = (TableData.Section.RxSwift, TableData.RxSwiftRow.allCases.map { "\($0)" })
        let uikitData: Data = (TableData.Section.UIKit, TableData.UIKitRow.allCases.map { "\($0)" })
        let swiftUIData: Data = (TableData.Section.SwiftUI, TableData.SwiftUIRow.allCases.map { "\($0)" })
        let rxCocoaData: Data = (TableData.Section.RxCocoa, TableData.RxCocoaRow.allCases.map { "\($0)" })
        tableData.append(swiftData)
        tableData.append(rxSwiftData)
        tableData.append(uikitData)
        tableData.append(swiftUIData)
        tableData.append(rxCocoaData)
    }
}
