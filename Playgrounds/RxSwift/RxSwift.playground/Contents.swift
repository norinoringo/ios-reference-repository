import UIKit
import RxSwift

let observable = Observable.of(
    "R",
    "Rx",
    "RxS",
    "RxSw",
    "RxSwi",
    "RxSwif",
    "RxSwift"
)

let observer = observable
    .subscribe(onNext: {
        print("onNext:", $0)
    })
