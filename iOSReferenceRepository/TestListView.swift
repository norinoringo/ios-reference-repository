//
//  TestListView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/14.
//  


import SwiftUI

struct TestListView: View {
    @ObservedObject var viewModel: TestListViewModel = TestListViewModel()

    var body: some View {
        NavigationView {
            // ここでZStackを使うことで、ListとNavigationLinkが同期できる
            ZStack {
                List {
                    if let fetchedData = viewModel.fetchedData {
                        ForEach(fetchedData, id: \.self) { data in
                            TestCell(data: data)
                            .onTapGesture {
                                viewModel.didTapList(selectedData: data)
                            }
                        }
                    }
                }
                if let selectedData = viewModel.selectedData {
                    NavigationLink(destination: NextListView(data: selectedData),
                                   isActive: $viewModel.isShowNextListView,
                                   label: {})
                }
            }.onAppear {
                viewModel.fetchData()
            }
        }
    }
}

extension TestListView {
    struct TestCell: View {
        let data: TestListViewModel.ListData

        var body: some View {
            HStack {
                data.thumbImage
                    .resizable()
                    .frame(width: 60, height: 60)
                VStack(spacing: 6) {
                    Text(data.title)
                        .font(.title)
                    Text(data.subTitle)
                        .font(.body)
                        .italic()
                }
            }
        }
    }
}

struct TestListView_Previews: PreviewProvider {
    static var previews: some View {
        TestListView()
    }
}

/*
 1. UITableViewControllerを使って、データを表示する画面を作成します。
 2. カスタムUITableViewCellを作成し、セル内に以下の要素を配置します。
    a. サムネイル画像 (左側に表示)
    b. タイトル (サムネイル画像の右側に表示、フォントサイズ: 20、太字)
    c. サブタイトル (タイトルの下に表示、フォントサイズ: 14、イタリック)
 3. セルの高さは、動的に変更できるように設定してください。
 4. 10個の要素が表示されるデータソースを作成し、それをテーブルビューに表示してください。
 5. セルをタップすると、選択されたセルの要素に関する詳細画面に遷移します。
 6. 詳細画面では、選択された要素の画像、タイトル、およびサブタイトルを表示します。
 */
