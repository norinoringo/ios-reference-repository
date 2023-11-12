//
//  GitHubSearchViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/10/20.
//  


import Foundation
import UIKit

class GitHubSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureTableView()
    }

    private func bind() {
        // TODO: ViewModelとデータバインディングする
    }

    private func configureTableView() {
        tableView.register(UINib(resource: R.nib.gitHubSearchTutorialLabelCell), forCellReuseIdentifier: R.nib.gitHubSearchTutorialLabelCell.identifier)
        tableView.register(UINib(resource: R.nib.gitHubSearchHistoryCell), forCellReuseIdentifier: R.nib.gitHubSearchHistoryCell.identifier)
        tableView.register(UINib(resource: R.nib.gitHubSearchHistoryHeader), forHeaderFooterViewReuseIdentifier: R.nib.gitHubSearchHistoryHeader.name)
        tableView.register(UINib(resource: R.nib.gitHubSearchSuggestionsCell), forCellReuseIdentifier: R.nib.gitHubSearchSuggestionsCell.identifier)
    }
}

extension GitHubSearchViewController: UITableViewDataSource {
    // TODO: TableViewのセルとセクションはViewModelから渡されたデータを使う
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 5
        } else if section == 2 {
            return 6
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: DATA層でモデルを定義して、その値を指定する
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  R.nib.gitHubSearchTutorialLabelCell.identifier, for: indexPath) as? GitHubSearchTutorialLabelCell else {
                return UITableViewCell()
            }
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchHistoryCell.identifier, for: indexPath) as? GitHubSearchHistoryCell else {
                return UITableViewCell()
            }
            cell.configureView(title: "Swift")
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchSuggestionsCell.identifier, for: indexPath) as? GitHubSearchSuggestionsCell else {
                return UITableViewCell()
            }
            cell.configureView(
                image: UIImage(systemName: "arrow.right") ?? UIImage(),
                               title: "Swiftへ移動"
            )
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension GitHubSearchViewController: UITableViewDelegate {
    // TODO: 検索履歴がない場合は表示しないロジックを実装する
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.gitHubSearchHistoryHeader.name) as? GitHubSearchHistoryHeader else {
                return nil
            }
            return header
        } else {
            return nil
        }
    }
}

extension GitHubSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}
