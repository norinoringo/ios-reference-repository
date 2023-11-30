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
    private var isShowTutorial = true
    private var isShowSearcHistories = true
    private var isShowSearchRepositories = false

    private let viewModel = GitHubSearchViewModel()
    private let disposeBag = DisposeBag()
    // Input
    private let inputtedKeywordsRelay = PublishRelay<String?>()
    private let tappedClearKeywordsButton = PublishRelay<Void>()
    private let tappedSearchHistoryButton = PublishRelay<Int>()
    private let tappedClearSearchHisoryButton = PublishRelay<Void>()
    private let tappedSearchRepositories = PublishRelay<Void>()
    private let tappedSearchIssues = PublishRelay<Void>()
    private let tappedSearchPullRequests = PublishRelay<Void>()
    private let tappedSearchUsers = PublishRelay<Void>()
    private let tappedSearchOrganizations = PublishRelay<Void>()
    private let tappedSearchKeywords = PublishRelay<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureTableView()
    }

    private func bind() {
        let input = GitHubSearchViewModel.Input(inputtedKeywords: inputtedKeywordsRelay.asDriver(onErrorJustReturn: nil),
                                                tappedClearKeywordsButton: tappedClearKeywordsButton.asDriver(onErrorJustReturn: ()),
                                                tappedSearchHistoryButton: tappedSearchHistoryButton.asDriver(onErrorJustReturn: 0),
                                                tappedClearSearchHisoryButton: tappedClearSearchHisoryButton.asDriver(onErrorJustReturn: ()),
                                                tappedSearchRepositories: tappedSearchRepositories.asDriver(onErrorJustReturn: ()),
                                                tappedSearchIssues: tappedSearchIssues.asDriver(onErrorJustReturn: ()),
                                                tappedSearchPullRequests: tappedSearchPullRequests.asDriver(onErrorJustReturn: ()),
                                                tappedSearchUsers: tappedSearchUsers.asDriver(onErrorJustReturn: ()),
                                                tappedSearchOrganizations: tappedSearchOrganizations.asDriver(onErrorJustReturn: ()),
                                                tappedSearchKeywords: tappedSearchKeywords.asDriver(onErrorJustReturn: ())
        )

        let output = viewModel.transform(input: input)

        output.searchKeyword
            .drive(onNext: { [weak self] keyword in
                self?.searchKeyword = keyword
                self?.searchBar.text = keyword
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
            return isShowSearcHistories ? 5 : 0
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
                cell.configureView(
                    image: UIImage(systemName: "arrow.right") ?? UIImage(),
                    title: "\(self.searchKeyword ?? "")" + "へ移動"
                )
                return cell
            }
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.gitHubSearchHistoryCell.identifier, for: indexPath) as? GitHubSearchHistoryCell else {
                return UITableViewCell()
            }
            cell.configureView(title: self.searchKeyword)
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
}

extension GitHubSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.inputtedKeywordsRelay.accept(searchText)
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchKeyword = nil
    }
}
