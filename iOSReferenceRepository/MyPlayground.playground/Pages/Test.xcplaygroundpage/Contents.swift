import Foundation

func test(int: Int) {
    guard int == 0 else {
        print("条件式：false")
        return
    }
    print("条件式：true")
    print(int)
}

test(int: 1)
test(int: 0)
