//
//  TopViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/09/11.
//  

import UIKit

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

extension TopViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopViewCell", for: indexPath) as! TopViewCell
        cell.configure(title: tableData[indexPath.section].rows[indexPath.row])
        return cell
    }
}

extension TopViewController: UITableViewDelegate {
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
            case "UIScrollView":
                self.navigationController?.pushViewController(ScrollViewController(), animated: true)
            default:
                return
            }
        case .SwiftUI:
            return
        case .RxCocoa:
            return
        }
    }
}
