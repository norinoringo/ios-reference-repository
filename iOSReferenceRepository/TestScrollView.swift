//
//  TestScrollView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/07.
//  


import SwiftUI

struct TestScrollView: View {
    var body: some View {
        VStack {
            Text("Title")
                .font(.largeTitle)
                .bold()
            Text("explanation")
                .font(.body)
                .italic()
            ScrollView(.vertical) {
                VStack(spacing: 100) {
                    ForEach(1 ..< 11, id: \.self) { index in
                        Text(String((index)))
                            .frame(width: 150,
                                   height: 150)
                            .background(Color.random)
                            .cornerRadius(10)
                    }
                }

            }
        }
    }
}

private extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct TestScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TestScrollView()
    }
}

/*
 VStackを使用して、タイトル、説明、およびScrollViewを含むViewを作成します。
 タイトルはテキストで、フォントサイズはLargeTitle、太字で表示してください。
 説明はテキストで、フォントサイズはBody、イタリックで表示してください。
 ScrollViewは、垂直方向（縦方向）にスクロールできるように設定してください。
 ScrollView内には、10個の矩形が表示されるようにしてください。それぞれの矩形は異なる色で表示され、テキストで矩形の番号が表示されます（1から10まで）。
 矩形のサイズは、幅150、高さ150に設定してください。また、矩形の角を丸めるために、cornerRadiusを適用してください。
 各矩形の上下には、適切な間隔を設けてください。
 */
