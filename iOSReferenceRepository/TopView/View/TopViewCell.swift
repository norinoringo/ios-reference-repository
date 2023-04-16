//
//  TopViewCell.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/11/11.
//  


import UIKit

class TopViewCell: UITableViewCell {
    @IBOutlet weak var sampleTitleLabel: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(title: String) {
        sampleTitleLabel.text = title
        self.accessoryType = .disclosureIndicator
    }
}
