//
//  UIKitSampleViewModel.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/04/03.
//

import Foundation
import RxSwift
import RxCocoa

class UIKitSampleViewModel {

    typealias items = (sections: UIkitSampleData.FrameWork, rows: [UIkitSampleData.Samples])

    struct Input {
        let viewDidAppear: Driver<Void>
        let didSelectRow: Driver<items>
    }

    struct Output {
        let tableData: Driver<[items]>
        // TODO: 他の画面も遷移処理を実装する
        let pushUIScrollView: Driver<Void>
    }

    private let disposeBag = DisposeBag()

    func transform(input: Input) -> Output {
        let tableDataRelay = PublishRelay<[items]>()
        let pushUIScrollViewRelay = PublishRelay<Void>()

        input.viewDidAppear
            .drive(onNext: { [weak self] _  in
                guard let self = self else {
                    return ()
                }
                tableDataRelay.accept(self.createTableData())
            })
            .disposed(by: disposeBag)

        input.didSelectRow
            .drive(onNext: { items in
                switch items.sections {
                case .UIKit:
                    switch items.rows.first {
                    case .UIScrollView:
                        pushUIScrollViewRelay.accept(())
                    default:
                        break
                    }
                case .RxCocoa: 
                    break
                case .None:
                    break
                }
            })
            .disposed(by: disposeBag)

        return Output(tableData: tableDataRelay.asDriver(onErrorJustReturn: []),
                      pushUIScrollView: pushUIScrollViewRelay.asDriver(onErrorJustReturn: ()))
    }

    private func createTableData() -> [items] {
        var tableData = [items]()
        // FIXME: $0.allCasesを使って簡潔に書ける気がする
        let uikitSamples = items(sections: UIkitSampleData.FrameWork.UIKit, rows: UIkitSampleData.Samples.allCases)
        tableData.append(uikitSamples)
        let rxcocoaSamples = items(sections: UIkitSampleData.FrameWork.RxCocoa, rows: [])
        tableData.append(rxcocoaSamples)

        return tableData
    }
}
