//
//  NextViewControllerFromTableView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/12.
//  


import Foundation
import UIKit

class NextViewControllerFromTableView: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!

    private let viewModel: TestUITableViewModel = TestUITableViewModel()

    var data: TestUITableViewModel.TableData?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    private func initView() {
        self.imageView.image = data?.thumbImage
        self.titleLabel.text = data?.title
        self.subTitle.text = data?.subTitle
    }
}
