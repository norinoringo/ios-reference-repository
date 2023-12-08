//
//  GitHubSearchViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/10/20.
//  


import Foundation
import UIKit
import RxSwift
import RxCocoa

class GitHubSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private var searchKeyword: String?
    private var searchHistroies: [String]?
    private var isShowTutorial = true
    private var isShowSearcHistories = true
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func bind() {

        let viewWillAppear = rx.sentMessage(#selector(viewWillAppear(_:)))
            .asDriver(onErrorJustReturn: [])
            .map { _ in
                ()
            }

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
                self?.searchBar.text = keyword
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        output.searchHistories
            .drive(onNext: { [weak self] hisories in
                self?.searchHistroies = hisories
                self?.tableView.reloadData()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return isShowSearchRepositories ? 1 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isShowTutorial ? 1 : 6
        } else if section == 1 {
            return isShowSearcHistories ? searchHistroies?.count ?? 0 : 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: DATA層でモデルを定義して、その値を指定する
        // FIXME: 検索候補セルを表示したときに他のsectionを非表示にしても余白ができてしまうので、動的に表示するセルを切り替えている。しかし実装が複雑になるのでこのやり方は辞めたい。
        if indexPath.section == 0 {
            if isShowTutorial {
                guard let cell = tableView.dequeueReusableCell(withIdentifier:  R.nib.gitHubSearchTutorialLabelCell.identifier, for: indexPath) as? GitHubSearchTutorialLabelCell else {
                    return UITableViewCell()
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchSuggestionsCell.identifier, for: indexPath) as? GitHubSearchSuggestionsCell else {
                    return UITableViewCell()
                }

                let searchCellData = viewModel.searchCellData[indexPath.row]
                cell.configureView(
                    image: searchCellData.image,
                    title: "\"\(self.searchKeyword ?? "")\"" + searchCellData.title
                )
                return cell
            }
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchHistoryCell.identifier, for: indexPath) as? GitHubSearchHistoryCell else {
                return UITableViewCell()
            }
            let history = searchHistroies?[indexPath.row]
            cell.configureView(title: history ?? "")
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
            header.historyClearRelay
                .asDriver(onErrorJustReturn: ())
                .drive(onNext: { [weak self] _ in
                    self?.tappedClearSearchHisoryButtonRelay.accept(())
                })
                .disposed(by: header.disposeBag)
            return isShowSearcHistories ? header : nil
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return isShowSearcHistories ? 54 : CGFloat.leastNormalMagnitude
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowSearcHistories {
            let hisory = searchHistroies?[indexPath.row]
            tappedSearchHistoryButtonRelay.accept(hisory ?? "")
        }
        if isShowSearchRepositories {
            switch viewModel.searchCellData[indexPath.row] {
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTextRelay.accept(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
