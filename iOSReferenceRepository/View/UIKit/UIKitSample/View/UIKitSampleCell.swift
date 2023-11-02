//
//  UIKitSampleCell.swift
//  iOSReferenceRepository
//
//  Created by hisanori on 2022/11/11.
//

import UIKit

class UIKitSampleCell: UITableViewCell {
    @IBOutlet var title: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(title: String) {
        self.title.text = title
        accessoryType = .disclosureIndicator
    }
}
