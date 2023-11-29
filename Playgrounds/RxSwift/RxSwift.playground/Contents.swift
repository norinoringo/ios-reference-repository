import Foundation
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

// Observableインスタンスはイベントを発火できない
// observable.just("RxSwift")

let observer1 = observable
    .subscribe(onNext: { (arg: String) -> Void in
        print("onNext: \(arg)")
    }, onCompleted: {
        print("onCompleted")
    })

let observer2 = Observable.just(10)
    .map({ (arg: Int) -> Int in
        print("arg: \(arg)")
        return arg * 2
    })
    .subscribe(onNext: { (arg: Int) -> Void in
        print("arg: \(arg)")
    }, onCompleted: {
        print("onCompleted")
    })

let subject = PublishSubject<String>()

let observer3 = subject
    .subscribe(onNext: { (arg: String) -> Void in
        print("onNext: \(arg)")
    }, onCompleted: {
        print("onCompleted")
    })

subject.onNext("A")
subject.onNext("B")
subject.onNext("C")
subject.onCompleted()
