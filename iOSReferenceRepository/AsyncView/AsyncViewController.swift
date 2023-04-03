import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay

class AsyncViewController : UIViewController {

    private let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
    }

    func async() {
    }
}

