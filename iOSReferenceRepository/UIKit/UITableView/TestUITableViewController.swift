//
//  TestUITableViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/11.
//  


import Foundation
import UIKit

class TestUITableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let viewModel: TestUITableViewModel = TestUITableViewModel()
    var tableData: [TestUITableViewModel.TableData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        tableData = viewModel.makeTableData()
        // これだとクラッシュする
        // tableView.register(TestUITableViewCell.self, forCellReuseIdentifier: "testUITableViewCell")
        tableView.register(UINib(nibName: "TestUITableViewCell", bundle: nil), forCellReuseIdentifier: "testUITableViewCell")
    }
}

extension TestUITableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableData[indexPath.row]
        // これだとクラッシュする
        // let cell = TestUITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "testUITableViewCell",
                                                       for: indexPath) as? TestUITableViewCell else {
            fatalError("The dequeued cell is not an instance of TestUITableViewCell.")
        }
        cell.configure(thumbImage: data.thumbImage,
                       title: data.title,
                       subTitle: data.subTitle)
        return cell
    }
}

extension TestUITableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = tableData[indexPath.row]

        let storyboard: UIStoryboard = UIStoryboard(name: "NextViewFromTableView", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "nextViewFromTableView") as? NextViewControllerFromTableView else { return }
        nextVC.data = data
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}



/*
 1. UITableViewControllerを使って、データを表示する画面を作成します。
 2. カスタムUITableViewCellを作成し、セル内に以下の要素を配置します。
    a. サムネイル画像 (左側に表示)
    b. タイトル (サムネイル画像の右側に表示、フォントサイズ: 20、太字)
    c. サブタイトル (タイトルの下に表示、フォントサイズ: 14、イタリック)
 3. セルの高さは、動的に変更できるように設定してください。
 4. 10個の要素が表示されるデータソースを作成し、それをテーブルビューに表示してください。
 5. セルをタップすると、選択されたセルの要素に関する詳細画面に遷移します。
 6. 詳細画面では、選択された要素の画像、タイトル、およびサブタイトルを表示します。
 */
