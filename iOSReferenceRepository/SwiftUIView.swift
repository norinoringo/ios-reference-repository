//
//  SwiftUIView.swift
//  
//  
//  Created by hisanori on 2023/03/17.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Color(.blue)
            .padding(EdgeInsets(top: 0,
                                leading: 110,
                                bottom: 10,
                                trailing: 50))
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
