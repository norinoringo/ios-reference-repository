//
//  NextListView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/15.
//  


import Foundation
import SwiftUI

struct NextListView: View {
    let thumbImage: Image
    let title: String
    let subTitle: String

    var body: some View {
        TestListView.TestCell(thumbImage: thumbImage,
                              titile: title,
                              subTitle: subTitle)
    }
}

struct NextListView_Previews: PreviewProvider {
    static var previews: some View {
        NextListView(thumbImage: Image(uiImage: R.image.sarunori()!),
                     title: "タイトル",
                     subTitle: "サブタイトル")
    }
}
