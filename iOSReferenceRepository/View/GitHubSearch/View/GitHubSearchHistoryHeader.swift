//
//  GitHubSearchHistoryHeader.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/11/04.
//

import Foundation
import UIKit

class GitHubSearchHistoryHeader: UITableViewHeaderFooterView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var clearButton: UIButton!

    @IBAction func tappedClearButton(_: Any) {
        // TODO: ViewModelへイベント伝搬するようにする
    }

    override func awakeFromNib() {}

    override func prepareForReuse() {}
}
