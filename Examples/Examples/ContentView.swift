//
//  ContentView.swift
//  Examples
//
//  Created by Cory Kilger.
//  Copyright Cory Kilger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Image Blending", destination: BlendingView())
                NavigationLink("Image Coloring", destination: ColoringView())
                NavigationLink("Image Resizing", destination: ResizingView())
                NavigationLink("Image Rounding", destination: RoundingView())
                NavigationLink("Image Trimming", destination: TrimmingView())
            }
            .navigationTitle("Examples")
        }
    }
}

#Preview {
    ContentView()
}
