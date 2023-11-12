//
//  GitHubSearchTutorialLabelCell.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/11/04.
//

import Foundation
import UIKit

class GitHubSearchTutorialLabelCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!

    override func awakeFromNib() {
        configureView()
    }

    override func prepareForReuse() {}

    private func configureView() {
        // Cellの背景色を親Viewの背景色にしたいけど、xib上でbackground = defaultしても背景色が白色になる。そのためクリアにすることで対応している
        backgroundColor = .clear
        titleLabel.text = String(localized: "GitHubSearchTutorialLabelTitle")
        subTitleLabel.text = String(localized: "GitHubSearchTutorialLabelSubTitle")
    }
}
