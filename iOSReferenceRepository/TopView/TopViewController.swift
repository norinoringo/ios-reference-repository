//
//  TopViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/09/11.
//  

import UIKit
import SwiftUI

class TopViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel: TopViewModel = TopViewModel()
    private var tableData: [TopViewModel.Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Top画面の表示")
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
        tableView.register(UINib(nibName: "TopViewCell", bundle: nil), forCellReuseIdentifier: "TopViewCell")
        tableView.register(UINib(nibName: "TopViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier:"TopViewHeader" )
    }
}

<<<<<<< HEAD
extension TopViewController {
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func initTableData() {
        let swiftData: TableData = (Section.Swift, [Cell.TableView, Cell.CollectionView])
        let rxswiftData: TableData = (Section.RxSwift, [Cell.未定])
        let swiftuiData: TableData = (Section.SwiftUI, [Cell.未定])

        tableData.append(swiftData)
        tableData.append(rxswiftData)
        tableData.append(swiftuiData)
    }
}


=======
>>>>>>> develop
extension TopViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopViewCell", for: indexPath) as! TopViewCell
        cell.configure(title: tableData[indexPath.section].rows[indexPath.row].rawValue)
        return cell
    }
}

extension TopViewController: UITableViewDelegate {
<<<<<<< HEAD
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableData[indexPath.section].cells[indexPath.row]
        switch cell {
        case .CollectionView:
            let nextVC = R.storyboard.collectionView().instantiateViewController(withIdentifier: "CollectionView") as! CollectionViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .TableView:
            return
        case .未定:
=======
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TopViewHeader") as! TopViewHeader
        header.configure(sectionTitle: tableData[section].section.rawValue)
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = tableData[indexPath.section]

        switch section.section {
        case .Swift:
            switch section.rows {
            default:
                return
            }
        case .RxSwift:
            return
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
            default:
                return
            }
        case .SwiftUI:
            switch section.rows[indexPath.row] {
            case .List:
                let vc = UIHostingController(rootView: TestListView())
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                return
            }
        case .RxCocoa:
>>>>>>> develop
            return
        }
    }
}
<<<<<<< HEAD

=======
>>>>>>> develop
