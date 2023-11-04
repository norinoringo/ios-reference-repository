//
//  GitHubSearchHistoryHeader.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/11/04.
//  


import Foundation
import UIKit

class GitHubSearchHistoryHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!

    @IBAction func tappedClearButton(_ sender: Any) {
    }

    override func awakeFromNib() {
    }

    override func prepareForReuse() {
    }
}
