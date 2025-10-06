//
//  CircleImage.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2025/10/06.
//  


import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("sarunori")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage()
}
