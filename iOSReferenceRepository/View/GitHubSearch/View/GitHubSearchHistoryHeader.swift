//
//  GitHubSearchHistoryHeader.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/11/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class GitHubSearchHistoryHeader: UITableViewHeaderFooterView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var clearButton: UIButton!

    let historyClearRelay = PublishRelay<Void>()
    let disposeBag = DisposeBag()

    @IBAction func tappedClearButton(_: Any) {
        historyClearRelay.accept(())
    }

    override func awakeFromNib() {}

    override func prepareForReuse() {}
}
