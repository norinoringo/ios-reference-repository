//
//  MapView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2025/10/09.
//  


import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        if #available(iOS 17.0, *) {
            Map(initialPosition: .region(region))
        } else {
            // Fallback on earlier versions
        }
    }

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(center: .init(latitude: 34.011_286,
                                         longitude: -116.166_868),
                           span: .init(latitudeDelta: 0.2,
                                       longitudeDelta: 0.2)
        )
    }
}

#Preview {
    MapView()
}
