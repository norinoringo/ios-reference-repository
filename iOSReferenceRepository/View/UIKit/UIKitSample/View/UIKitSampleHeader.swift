//
//  UIKitSampleHeader.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2022/11/12.
//  


import UIKit

class UIKitSampleHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(title: String) {
        self.title.text = title
    }
}
