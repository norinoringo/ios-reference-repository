//
//  GitHubSearchHistoryHeader.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/11/04.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class GitHubSearchHistoryHeader: UITableViewHeaderFooterView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var clearButton: UIButton!

    let historyClearRelay = PublishRelay<Void>()
    let disposeBag = DisposeBag()

    override func awakeFromNib() {}

    override func prepareForReuse() {}

    override func willMove(toSuperview _: UIView?) {
        // UITableViewHeaderFooterViewは、非表示になるとUIButtonのtarget/actionが解除される仕様なので、再設定している
        clearButton.addTarget(self, action: #selector(tappedClearButton), for: .touchUpInside)
    }

    @objc func tappedClearButton() {
        historyClearRelay.accept(())
    }
}
