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
    private var searchHistroies: [String]?
    private var isShowTutorial = false
    private var isShowSearcHistories = false
    private var isShowSearchRepositories = false

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

        output.searchHistories
            .drive(onNext: { [weak self] hisories in
                self?.searchHistroies = hisories
            })
            .disposed(by: disposeBag)

        output.isShowTutorial
            .drive(onNext: { [weak self] isShow in
                self?.isShowTutorial = isShow
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        output.isShowSearchHistories
            .drive(onNext: { [weak self] isShow in
                self?.isShowSearcHistories = isShow
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        output.isShowSearchConditions
            .drive(onNext: { [weak self] isShow in
                self?.isShowSearchRepositories = isShow
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
    // TODO: TableViewのセルとセクションはViewModelから渡されたデータを使う
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if isShowTutorial {
            return 1
        } else if isShowSearcHistories {
            return searchHistroies?.count ?? 0
        } else if isShowSearchRepositories {
            return viewModel.searchSuggesionsCellData.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: DATA層でモデルを定義して、その値を指定する
        // FIXME: 検索候補セルを表示したときに他のsectionを非表示にしても余白ができてしまうので、動的に表示するセルを切り替えている。しかし実装が複雑になるのでこのやり方は辞めたい。
        if isShowTutorial {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchTutorialLabelCell.identifier, for: indexPath) as? GitHubSearchTutorialLabelCell else {
                return UITableViewCell()
            }
            return cell
        } else if isShowSearcHistories {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchHistoryCell.identifier, for: indexPath) as? GitHubSearchHistoryCell else {
                return UITableViewCell()
            }
            let history = searchHistroies?[indexPath.row]
            cell.configureView(title: history ?? "")
            return cell
        } else if isShowSearchRepositories {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchSuggestionsCell.identifier, for: indexPath) as? GitHubSearchSuggestionsCell else {
                return UITableViewCell()
            }

            let searchSuggesionsCell = viewModel.searchSuggesionsCellData[indexPath.row]
            cell.configureView(
                image: searchSuggesionsCell.image,
                title: "\"\(searchKeyword ?? "")\"" + searchSuggesionsCell.title
            )
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension GitHubSearchViewController: UITableViewDelegate {
    // TODO: 検索履歴がない場合は表示しないロジックを実装する
    func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.gitHubSearchHistoryHeader.name) as? GitHubSearchHistoryHeader, isShowSearcHistories else {
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

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return isShowSearcHistories ? 54 : CGFloat.leastNormalMagnitude
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowSearcHistories {
            let hisory = searchHistroies?[indexPath.row]
            tappedSearchHistoryButtonRelay.accept(hisory ?? "")
        }
        if isShowSearchRepositories {
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
