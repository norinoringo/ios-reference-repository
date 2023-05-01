import Foundation

// コールバック関数
// completionHandlerのクロージャー実行には[Stirng]が必要で、クロージャー実行時の戻り値はVoid
func completion(completionHandler: ([String]) -> Void) {
    let strings = ["aaa", "bbb", "ccc"]
    completionHandler(strings)
}

// コールバック関数の呼び出しの基本形
// これが色んなOperatorの使われ方！
completion { result in
    print(result)
}

// 省略なし
// コールバック関数を呼び出す際に、引数にクロージャーを渡している
// コールバック関数の実行結果をresultで受け取ることができる仕組み
completion(completionHandler: { (result: [String]) -> Void in
    print(result)
})

// 引数の省略
completion(completionHandler: { result in
    print(result)
})

// トレイリングクロージャー
completion() { result in
    print(result)
}
