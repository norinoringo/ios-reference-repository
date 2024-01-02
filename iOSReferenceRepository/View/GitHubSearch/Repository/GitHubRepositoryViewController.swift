//
//  GitHubRepositoryViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/30.
//  

import Foundation
import UIKit
import RxSwift
import RxCocoa

class GitHubRepositoryViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var searchText = ""

    private let viewModel = GitHubRepositoryViewModel()
    private var repositories = GitHubSearchResponse.Repository(items: [])

    private let searchRelay = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureTableView()
        searchRelay.accept(searchText)
    }

    private func bind() {
        let input = GitHubRepositoryViewModel.Input(searchText: searchRelay.asDriver(onErrorJustReturn: ""))

        let output = viewModel.tranform(input: input)

        output.repositories
            .drive(onNext: { [weak self] repositories in
                self?.repositories = repositories
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func configureTableView() {
        tableView.register(UINib(resource: R.nib.gitHubRepositoryCell), forCellReuseIdentifier: R.nib.gitHubRepositoryCell.identifier)
    }
}

extension GitHubRepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubRepositoryCell.identifier, for: indexPath) as? GitHubRepositoryCell else {
            return UITableViewCell()
        }
        if repositories.items.count > indexPath.row {
            let item = repositories.items[indexPath.row]
            cell.configure(avatar: item.owner.avatarURL,
                           login: item.owner.login,
                           name: item.name,
                           description: item.description,
                           stargazersCount: item.stargazersCount,
                           language: item.language)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
