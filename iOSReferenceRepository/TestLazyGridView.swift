//
//  TestLazyGridView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/21.
//  


import SwiftUI

struct TestLazyGridView: View {
    @ObservedObject var viewModel: TestLazyGridViewModel

    init(viewModel:TestLazyGridViewModel = TestLazyGridViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            // GridViewのレイアウトを指定する
            let grids = [GridItem(.adaptive(minimum: 100))]

            LazyVGrid(columns: grids) {
                ForEach(viewModel.gridData, id: \.self) { data in
                    TestLazyGridView.GridView(data: data)
                }
            }.padding()
        }
        .onAppear() {
            print("LazyGrid画面の表示")
            viewModel.fetchData()
        }
    }
}

struct TestLazyGridView_Previews: PreviewProvider {
    static var previews: some View {
        TestLazyGridView()
    }
}

extension TestLazyGridView {
    struct GridView: View {

        let data: TestLazyGridViewModel.GridData

        var body: some View {
            let isSoldOut = data.isSoldOut

            ZStack(alignment: .leading) {
                data.thumbImage
                    .resizable()
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    if isSoldOut {
                        Image(uiImage: R.image.pop_sold_out()!)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    Spacer()
                    Text("¥\(data.price)")
                }
            }.frame(width: 100, height: 100)
        }
    }
}

struct TestGridView_Previews: PreviewProvider {
    static var previews: some View {
        TestLazyGridView.GridView(data: .init(thumbImage: Image(uiImage: R.image.sarunori()!),
                                              price: 1000,
                                              isSoldOut: true))
    }
}
