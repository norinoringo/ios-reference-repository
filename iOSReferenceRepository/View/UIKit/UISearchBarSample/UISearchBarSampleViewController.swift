//
//  UISearchBarSampleViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/11/02.
//  


import Foundation
import RxSwift
import RxCocoa

class UISearchBarSampleViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBar2: UISearchBar!
    
    private let viewModel = UISearchBarSampleViewModel()

    private let textDidChangeRelay = PublishRelay<String?>()
    private let cancelButtonClickedRelay = PublishRelay<Void>()
    private let searchButtonClickedRelay = PublishRelay<Void>()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        searchBar.delegate = self
        searchBar2.delegate = self
        
        let viewDidAppearRelay = rx.sentMessage(#selector(viewDidAppear(_:)))
            .asDriver(onErrorJustReturn: [])
            .map { _ in
                ()
            }

        let input = UISearchBarSampleViewModel.Input(
            viewDidAppear: viewDidAppearRelay,
            textDidChange: textDidChangeRelay.asDriver(onErrorJustReturn: nil),
            cancelButtonClicked: cancelButtonClickedRelay.asDriver(onErrorJustReturn: ()),
            searchButtonClicked: searchButtonClickedRelay.asDriver(onErrorJustReturn: ())
        )

        let output = viewModel.transform(input: input)

        output.searchText
            .drive(onNext: { [weak self] text in
                self?.searchBar.text = text
                self?.searchBar2.text = text
            })
            .disposed(by: disposeBag)
    }
}

extension UISearchBarSampleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textDidChangeRelay.accept(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelButtonClickedRelay.accept(())
    }
}
