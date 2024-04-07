import Hydra

private func basicPromise(isResolved: Bool) -> Promise<String> {
    return Promise<String>(in: .background) { resolve, reject, promise in
        if isResolved {
            resolve("Promise is Resolved") // クロージャ実行
        } else {
            // Errorを継承していないとコンパイルエラーになる
            reject(PromiseError.rejected) // クロージャ実行
        }
    }
}

func testPromiseChain(isResolved: Bool) -> Promise<Void> {
    return Promise<Void>(in: .background) { resolve, reject, promise in
        basicPromise(isResolved: isResolved).then { string in
            // Promiseをチェーンするためには、各.then内でreturn Promiseオブジェクトする必要がある
            return basicPromise(isResolved: isResolved)
        }.then { _ in
            print("basicPromise is resolved")
            resolve(())
        }.catch { error in
            reject(error)
        }
    }
}

func testPromiseChainWithGuard(isResolved: Bool) -> Promise<Void> {
    return Promise<Void>(in: .background) { resolve, reject, promise in
        basicPromise(isResolved: isResolved).then { string in
            guard string.isEmpty else {
                throw PromiseError.rejected // throwすることで.catchにイベントが流れる
            }
            return basicPromise(isResolved: isResolved)
        }.then { _ in
            print("basicPromise is resolved")
            resolve(())
        }.catch { error in
            print("basicPromise is rejected")
            reject(error)
        }
    }
}

testPromiseChain(isResolved: true).then { _ in
    print("testPromiseChain is resolved")
}.catch { error in
    print("testPromiseChain is rejected")
}
