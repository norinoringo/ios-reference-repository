//
//  TestUICollectionViewController.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/16.
//  

import UIKit

class TestUICollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel: TestCollectionViewModel
    private let margin: CGFloat = 10

    var collectionData: [TestCollectionViewModel.Data] = []

    init(viewModel: TestCollectionViewModel = TestCollectionViewModel()) {
        self.viewModel = viewModel
        super.init()
    }

    /// Xibファイルで作られたViewControllerのインスタンス化する際に必要
    required init?(coder: NSCoder) {
        self.viewModel = TestCollectionViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        print("UICollectionView画面の表示")
    }

    private func initView() {
        collectionData = viewModel.fetchData()

        // XibのUICollectionViewのestimatedItemSize = auto(初期値)だと、UICollectionViewDelegateFlowLayoutで指定したサイズにならない。そのためestimatedItemSize = .zeroにすることで指定したサイズでCellが表示されるようになる
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = .zero
        }

        collectionView.register(UINib(nibName: "TestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TestCollectionViewCell")
    }

}

extension TestUICollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as! TestCollectionViewCell

        cell.configure(data: collectionData[indexPath.row])
        return cell
    }
}

extension TestUICollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 2 == 0 {
            return CGSize(width: 100, height: 100)
        } else {
            return CGSize(width: 200, height: 200)
        }
    }
}
