//
//  TopViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/09/11.
//  

import UIKit
import SwiftUI
import RxSwift

class UIKitSampleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel = UIKitSampleViewModel()
    private var tableData = [UIKitSampleViewModel.items]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UIKitSample画面の表示")
        setup()
    }

    func setup() {
        initView()
        register()
    }

    private func initView() {
        self.tableData = viewModel.tableData
    }

    private func register() {
        tableView.register(UINib(nibName: "UIKitSampleCell", bundle: nil), forCellReuseIdentifier: "UIKitSampleCell")
        tableView.register(UINib(nibName: "UIKitSampleHeader", bundle: nil), forHeaderFooterViewReuseIdentifier:"UIKitSampleHeader" )
    }
}

extension UIKitSampleViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UIKitSampleCell", for: indexPath) as? UIKitSampleCell else {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = tableData[indexPath.section]

        switch section.sections {
        case .UIKit:
            switch section.rows[indexPath.row] {
            case .UIScrollView:
                let nextVC = R.storyboard.scrollView.instantiateInitialViewController()
                guard let nextVC = nextVC else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            case.UITableView:
                let nextVC = R.storyboard.testUITableView().instantiateInitialViewController()
                guard let nextVC = nextVC else {
                    return
                }
                self.navigationController?.pushViewController(nextVC, animated: true)
            case .UICollectionView:
                let storyboard = UIStoryboard(name: "TestUICollectionView", bundle: nil)
                guard let nextVC = storyboard.instantiateViewController(withIdentifier: "TestUICollectionView") as? TestUICollectionViewController else { return }
                self.navigationController?.pushViewController(nextVC, animated: true)
            default:
                return
            }
        case .RxCocoa:
            return
        }
    }
}
