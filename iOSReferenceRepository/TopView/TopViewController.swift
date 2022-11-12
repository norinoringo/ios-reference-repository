//
//  TopViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/09/11.
//  

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    typealias TableData = (section: Section, cells: [Cell])
    private var tableData: [TableData] = []

    enum Section: String {
        case Swift
        case RxSwift
        case SwiftUI
    }

    enum Cell: String {
        // Swift
        case TableView
        case CollectionView
        // RxSwift
        case GitHubSample
        // SwiftUI
        case 未定
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Top画面の表示")
        initTableView()
    }
}

extension TopViewController {

    func initTableView() {
        register()
        initTableData()
    }

    func initTableData() {
        let swiftData: TableData = (Section.Swift, [Cell.TableView, Cell.CollectionView])
        let rxswiftData: TableData = (Section.RxSwift, [Cell.GitHubSample])
        let swiftuiData: TableData = (Section.SwiftUI, [Cell.未定])
        tableData.append(swiftData)
        tableData.append(rxswiftData)
        tableData.append(swiftuiData)
    }
}

extension TopViewController: UITableViewDataSource, UITableViewDelegate {

    func register() {
        tableView.register(UINib(nibName: "TopViewCell", bundle: nil), forCellReuseIdentifier: "TopViewCell")
        tableView.register(UINib(nibName: "TopViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier:"TopViewHeader" )
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].cells.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TopViewHeader") as! TopViewHeader
        header.configure(sectionTitle: tableData[section].section.rawValue)
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopViewCell", for: indexPath) as! TopViewCell
        cell.configure(title: tableData[indexPath.section].cells[indexPath.row].rawValue)
        return cell
    }
}

