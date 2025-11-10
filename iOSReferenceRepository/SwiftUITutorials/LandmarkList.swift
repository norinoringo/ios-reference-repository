//
//  LandmarkList.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2025/11/10.
//  


import SwiftUI

struct LandmarkList: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationSplitView {
                List(landmarks, id: \.id) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
                .navigationTitle("Landmark")
            } detail: {
                Text("Select a Landmark")
            }
        } else {

        }
    }
}

#Preview {
    LandmarkList()
}
