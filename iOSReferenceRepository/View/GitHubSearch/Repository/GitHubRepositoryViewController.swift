//
//  GitHubRepositoryViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/30.
//  

import Foundation
import UIKit

class GitHubRepositoryViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var searchText: String!

    private let viewModel = GitHubRepositoryViewModel()
    private var repositories = [GitHubSearchResponse.Repository]()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
    }
}
