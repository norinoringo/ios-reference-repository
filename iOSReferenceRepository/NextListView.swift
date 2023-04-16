//
//  NextListView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/15.
//  


import Foundation
import SwiftUI

struct NextListView: View {
    let data: TestListViewModel.ListData

    var body: some View {
        TestListView.TestCell(data: data)
    }
}

struct NextListView_Previews: PreviewProvider {
    static var previews: some View {
        let data = TestListViewModel.ListData(thumbImage: Image(uiImage: R.image.sarunori()!),
                                              title: "タイトル",
                                              subTitle: "サブタイトル")
        NextListView(data: data)
    }
}
