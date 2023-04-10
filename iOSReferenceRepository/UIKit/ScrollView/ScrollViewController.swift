//
//  ScrollViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/03/25.
//  

import Foundation
import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("UIScrollViewの表示")
        initView()
    }

    private func initView() {
        let subView = createContentsView()
        scrollView.addSubview(subView)
        scrollView.contentSize = subView.frame.size
    }

    func createContentsView() -> UIView {
        let contentsView = UIView()
        contentsView.frame = CGRect(x: 0,
                                    y: 0,
                                    width: 1000,
                                    height: 2000)

        let label = createLabel(contentsView: contentsView)
        contentsView.addSubview(label)
        return contentsView
    }

    func createLabel(contentsView: UIView) -> UILabel {
        let label = UILabel()
        label.frame = CGRect(x: contentsView.center.x,
                             y: contentsView.center.y,
                             width: 100,
                             height: 50)
        label.text = "Label"
        return label
    }
}
