//
//  ContentView.swift
//  iOSReferenceRepository
//  
//  Created by hisanori on 2025/10/06.
//  


import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Turtle Rock")
                    .font(.title)
                HStack {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    Spacer()
                    Text("California")
                        .font(.subheadline)
                }
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)

            Divider()

            Text("About Turtle Rock")
                .font(.title2)
            Text("Descriptive text goes here.")
        }
        .padding()

        Spacer()
    }
}

#Preview {
    ContentView()
}
