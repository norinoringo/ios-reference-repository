//
//  TestScrollView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2023/04/07.
//  


import SwiftUI

struct TestScrollView: View {
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            Text("テキスト")
                .frame(width: 100,
                       height: 200)
        }
    }
}

struct TestScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TestScrollView()
    }
}
