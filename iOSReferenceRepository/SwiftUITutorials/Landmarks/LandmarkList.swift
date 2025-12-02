//
//  LandmarkList.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2025/11/10.
//  


import SwiftUI

@available(iOS 17.0, *)
struct LandmarkList: View {
    
    @Environment(ModelData.self) var modelData
    @State private var showFavoritesOnly = false

    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationSplitView {
                List {
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Favorites only")
                    }

                    ForEach (filteredLandmarks) { landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            LandmarkRow(landmark: landmark)
                        }
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

@available(iOS 17.0, *)
#Preview {
    LandmarkList()
        .environment(ModelData())
}
