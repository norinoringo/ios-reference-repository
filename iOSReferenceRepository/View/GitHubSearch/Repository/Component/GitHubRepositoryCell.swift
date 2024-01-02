//
//  GitHubRepositoryCell.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/12/30.
//  


import Foundation
import UIKit

class GitHubRepositoryCell: UITableViewCell {
    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var ownerLogin: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var stargazersCount: UILabel!
    @IBOutlet weak var language: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        ownerAvatar.image = nil
        ownerLogin.text = nil
        self.name.text = nil
        descriptions.text = nil
        self.stargazersCount.text = nil
        self.language.text = nil
    }

    func configure(avatar: UIImage, login: String, name: String, description: String, stargazersCount: Int, language: String) {
        ownerAvatar.image = avatar
        ownerLogin.text = login
        self.name.text = name
        descriptions.text = description
        // TODO: Int → 桁数区切りしたStringに変換する
        self.stargazersCount.text = stargazersCount.description
        self.language.text = language
    }
}
