//
//  TrimmingView.swift
//  Examples
//
//  Created by Cory Kilger on 1/24/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

import SwiftUI
import CKImageAdditions

struct TrimmingView: View {
    private let sourceImage = UIImage(named: "test3")!

    @State private var displayedImage: UIImage?
    @State private var isTrimmed = false

    var body: some View {
        VStack {
            Image(uiImage: displayedImage ?? sourceImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.3))

            Button(isTrimmed ? "Reset" : "Trim Transparency") {
                if isTrimmed {
                    displayedImage = sourceImage
                    isTrimmed = false
                } else {
                    displayedImage = sourceImage.trimmingTransparency()
                    isTrimmed = true
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Image Trimming")
    }
}

#Preview {
    TrimmingView()
}
