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
    }

    private func bind() {
        configureTableView()
        configureSearchBar()
    }

    private func configureTableView() {
        tableView.register(UINib(resource: R.nib.gitHubSearchTutorialLabelCell), forCellReuseIdentifier: R.nib.gitHubSearchTutorialLabelCell.identifier)
    }

    private func configureSearchBar() {
    }
}

extension GitHubSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  R.nib.gitHubSearchTutorialLabelCell.identifier, for: indexPath) as? GitHubSearchTutorialLabelCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension GitHubSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}
