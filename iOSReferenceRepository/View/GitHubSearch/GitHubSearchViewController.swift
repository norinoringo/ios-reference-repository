//
//  GitHubSearchViewController.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/10/20.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class GitHubSearchViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    private var searchKeyword: String?
    private var screenType: GitHubSearchViewModel.screenType = .none

    private let viewModel = GitHubSearchViewModel()
    private let disposeBag = DisposeBag()
    // Input
    private let searchTextRelay = PublishRelay<String?>()
    private let tappedSearchHistoryButtonRelay = PublishRelay<String>()
    private let tappedClearSearchHisoryButtonRelay = PublishRelay<Void>()
    private let tappedSearchRelay = PublishRelay<GitHubSearchType>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureTableView()
        // この画面はNavigationBar不要なので、hiddenして上余白を詰めている
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func bind() {
        let viewWillAppear = rx.sentMessage(#selector(viewWillAppear(_:)))
            .asDriver(onErrorJustReturn: [])
            .mapToVoid()

        let input = GitHubSearchViewModel.Input(
            viewWillAppear: viewWillAppear,
            searchText: searchTextRelay.asDriver(onErrorJustReturn: nil),
            tappedSearchHistoryButton: tappedSearchHistoryButtonRelay.asDriver(onErrorJustReturn: ""),
            tappedClearSearchHisoryButton: tappedClearSearchHisoryButtonRelay.asDriver(onErrorJustReturn: ()),
            tappedSearch: tappedSearchRelay.asDriver(onErrorJustReturn: GitHubSearchType.keyword(searchText: ""))
        )

        let output = viewModel.transform(input: input)

        output.searchKeyword
            .drive(onNext: { [weak self] keyword in
                self?.searchKeyword = keyword
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        output.screenType
            .drive(onNext: { [weak self] type in
                self?.screenType = type
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func configureTableView() {
        tableView.register(UINib(resource: R.nib.gitHubSearchTutorialLabelCell), forCellReuseIdentifier: R.nib.gitHubSearchTutorialLabelCell.identifier)
        tableView.register(UINib(resource: R.nib.gitHubSearchHistoryCell), forCellReuseIdentifier: R.nib.gitHubSearchHistoryCell.identifier)
        tableView.register(UINib(resource: R.nib.gitHubSearchHistoryHeader), forHeaderFooterViewReuseIdentifier: R.nib.gitHubSearchHistoryHeader.name)
        tableView.register(UINib(resource: R.nib.gitHubSearchSuggestionsCell), forCellReuseIdentifier: R.nib.gitHubSearchSuggestionsCell.identifier)
    }
}

extension GitHubSearchViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        switch screenType {
        case .tutorial:
            return 1
        case .searchHistories:
            return viewModel.searchHistories.count
        case .searchConditions:
            return viewModel.searchSuggesionsCellData.count
        case .none:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch screenType {
        case .tutorial:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchTutorialLabelCell.identifier, for: indexPath) as? GitHubSearchTutorialLabelCell else {
                return UITableViewCell()
            }
            return cell
        case .searchHistories:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchHistoryCell.identifier, for: indexPath) as? GitHubSearchHistoryCell else {
                return UITableViewCell()
            }
            cell.configureView(title: viewModel.searchHistories[indexPath.row])
            return cell
        case .searchConditions:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchSuggestionsCell.identifier, for: indexPath) as? GitHubSearchSuggestionsCell else {
                return UITableViewCell()
            }

            let searchSuggesionsCell = viewModel.searchSuggesionsCellData[indexPath.row]
            cell.configureView(
                image: searchSuggesionsCell.image,
                title: "\"\(searchKeyword ?? "")\"" + searchSuggesionsCell.title
            )
            return cell
        case .none:
            return UITableViewCell()
        }
    }
}

extension GitHubSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        switch screenType {


        case .tutorial, .searchConditions, .none:
            return nil
        case .searchHistories:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.gitHubSearchHistoryHeader.name) as? GitHubSearchHistoryHeader else {
                return nil
            }
            header.historyClearRelay
                .asDriver(onErrorJustReturn: ())
                .drive(onNext: { [weak self] _ in
                    self?.tappedClearSearchHisoryButtonRelay.accept(())
                })
                .disposed(by: header.disposeBag)
            return header
        }
    }


    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        switch screenType {
        case .tutorial, .searchConditions, .none:
            return .leastNormalMagnitude
        case .searchHistories:
            return 54
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch screenType {
        case .tutorial, .none:
            return
        case .searchHistories:
            tappedSearchHistoryButtonRelay.accept(viewModel.searchHistories[indexPath.row])
        case .searchConditions:
            switch viewModel.searchSuggesionsCellData[indexPath.row].type {
            case .repositories:
                tappedSearchRelay.accept(.repositories(searchText: searchKeyword ?? ""))
            case .issues:
                tappedSearchRelay.accept(.issues(searchText: searchKeyword ?? ""))
            case .pullRequests:
                tappedSearchRelay.accept(.pullRequests(searchText: searchKeyword ?? ""))
            case .users:
                tappedSearchRelay.accept(.users(searchText: searchKeyword ?? ""))
            case .organizations:
                tappedSearchRelay.accept(.organizations(searchText: searchKeyword ?? ""))
            case .keyword:
                tappedSearchRelay.accept(.keyword(searchText: searchKeyword ?? ""))
            }
        }
    }
}

extension GitHubSearchViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        searchTextRelay.accept(searchText)
    }

    func searchBarSearchButtonClicked(_: UISearchBar) {
        view.endEditing(true)
    }
}
