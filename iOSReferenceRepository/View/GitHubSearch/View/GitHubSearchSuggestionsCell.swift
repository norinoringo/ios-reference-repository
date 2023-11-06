//
//  GitHubSearchSuggestionsCell.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2023/11/04.
//

import Foundation
import UIKit

class GitHubSearchSuggestionsCell: UITableViewCell {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        initView()
    }

    override func prepareForReuse() {}

    private func initView() {
        accessoryType = .disclosureIndicator
        // separatorのレイアウト調整
        self.separatorInset = UIEdgeInsets(top: 0, left: iconImage.frame.width, bottom: 0, right: 0)
    }

    func configureView(image: UIImage, title: String) {
        iconImage.image = image
        titleLabel.text = title
    }
}
