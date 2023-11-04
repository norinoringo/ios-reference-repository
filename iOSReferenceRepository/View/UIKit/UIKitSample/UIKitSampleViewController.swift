//
//  TopViewController.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2022/09/11.
//

import RxCocoa
import RxSwift
import SwiftUI
import UIKit

class UIKitSampleViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    private let viewModel = UIKitSampleViewModel()
    private var tableData = [UIKitSampleViewModel.items]()
    // タップされたセル情報を流すRelay
    private var didSelectItemRelay = PublishRelay<UIKitSampleViewModel.items>()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UIKitSample画面の表示")
        bind()
        register()
    }

    private func bind() {
        let viewDidAppear = rx.sentMessage(#selector(viewDidAppear(_:)))
            .asDriver(onErrorJustReturn: [])
            .map { _ in
                ()
            }

        let input = UIKitSampleViewModel.Input(viewDidAppear: viewDidAppear,
                                               didSelectRow: didSelectItemRelay.asDriver(onErrorJustReturn: (sections: UIkitSampleData.FrameWork.None, rows: [])))

        let output = viewModel.transform(input: input)

        output.tableData
            .drive(onNext: { [weak self] items in
                self?.tableData = items
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        // TODO: 他の画面も遷移処理を実装する
        output.pushUIScrollView
            .drive(onNext: { [weak self] _ in

                guard let nextVC = R.storyboard.scrollView.instantiateInitialViewController() else {
                    return
                }
                self?.navigationController?.pushViewController(nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func register() {
        tableView.register(UINib(nibName: R.nib.uiKitSampleCell.name, bundle: nil), forCellReuseIdentifier: R.nib.uiKitSampleCell.identifier)
        tableView.register(UINib(nibName: R.nib.uiKitSampleHeader.name, bundle: nil), forHeaderFooterViewReuseIdentifier: R.nib.uiKitSampleHeader.name)
    }
}

extension UIKitSampleViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.uiKitSampleCell.identifier, for: indexPath) as? UIKitSampleCell else {
            return UITableViewCell()
        }
        cell.configure(title: tableData[indexPath.section].rows[indexPath.row].title)
        return cell
    }
}

extension UIKitSampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UIKitSampleHeader") as? UIKitSampleHeader else {
            return UIView()
        }
        header.configure(title: tableData[section].sections.title)
        return header
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = UIKitSampleViewModel.items(sections: tableData[indexPath.section].sections,
                                              rows: [tableData[indexPath.section].rows[indexPath.row]])

        didSelectItemRelay.accept(item)
    }
}
