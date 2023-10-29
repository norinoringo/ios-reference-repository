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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func bind() {
        configureSearchBar()
    }

    private func configureSearchBar() {
        self.searchBar.delegate = self
    }
}

extension GitHubSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
}
