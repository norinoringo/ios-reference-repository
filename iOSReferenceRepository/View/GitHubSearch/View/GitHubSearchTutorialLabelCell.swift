//
//  GitHubSearchTutorialLabelCell.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/11/04.
//  


import Foundation
import UIKit

class GitHubSearchTutorialLabelCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        configureView()
    }

    override func prepareForReuse() {

    }

    private func configureView() {
        // xib上でbackgroundColorをclearにしても反映されなかったので、ここで明示的に宣言している
        backgroundColor = .clear
        titleLabel.text = String(localized: "GitHubSearchTutorialLabelTitle")
        subTitleLabel.text = String(localized: "GitHubSearchTutorialLabelSubTitle")
    }
}
