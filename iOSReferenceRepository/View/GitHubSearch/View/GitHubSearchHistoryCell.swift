//
//  GitHubSearchHistoryCell.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/11/04.
//  


import Foundation
import UIKit

class GitHubSearchHistoryCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        initView()
    }

    override func prepareForReuse() {
        title.text = nil
    }

    private func initView() {
        // RenderingMode.alwaysTemplateにしないとTintColorがあたらない
        let imageView = UIImageView(image: .init(systemName: "arrow.up.left")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .lightGray
        self.accessoryView = imageView
    }

    func configureView(title: String?) {
        self.title.text = title
    }
}
