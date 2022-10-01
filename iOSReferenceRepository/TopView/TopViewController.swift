//
//  TopViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/09/11.
//  

/*
 TableViewの実装
 - .storyboard
    - ViewControllerにTableViewを追加
    - TableViewCellを追加
 - ViewController
    - UITableViewDataSource Protocolを継承
        - func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {}
        - func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {}
            - let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        - tableView.dataSource = self
*/


import Foundation
import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    typealias TableData = (section :Section, cells: [Cell])
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
        // SwiftUI
        case 未定
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Top画面の表示")

        initTableView()
        initTableData()
    }
}

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


extension TopViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tableData[0].cells.count
        } else if section == 1 {
            return tableData[1].cells.count
        } else if section == 2 {
            return tableData[2].cells.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return initCell(indexPath: indexPath)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableData[section].section.rawValue
    }

    private func initCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = tableData[indexPath.section].cells[indexPath.row].rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cell = tableData[indexPath.section].cells[indexPath.row]
        switch cell {
        case .CollectionView:
            let nextVC = R.storyboard.collectionView().instantiateViewController(withIdentifier: "CollectionView") as! CollectionViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .TableView:
            return
        case .未定:
            return
        }
    }
}

