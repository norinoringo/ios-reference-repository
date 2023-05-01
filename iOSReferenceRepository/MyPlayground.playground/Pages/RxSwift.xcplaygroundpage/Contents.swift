import RxSwift

private let disposeBag = DisposeBag()

let stream = PublishSubject<Int>()
 _ = stream
    .distinctUntilChanged()
    .subscribe {
        print($0)
    }.disposed(by: disposeBag)

/// 出力結果
stream.onNext(1)
stream.onNext(2)
stream.onNext(3)
stream.onNext(3)
stream.onNext(4)

/// 実行結果
/*
next(1)
next(2)
next(3)
next(4)
*/
