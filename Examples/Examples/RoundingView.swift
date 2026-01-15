//
//  RoundingView.swift
//  Examples
//
//  Created by Cory Kilger on 1/21/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

import SwiftUI
import CKImageAdditions

struct RoundingView: View {
    private let sourceImage = UIImage(named: "ninja_disguise")!

    @State private var cornerRadius: Float = 25

    private var roundedImage: UIImage {
        sourceImage.withRoundedCorners(CGFloat(cornerRadius))
    }

    var body: some View {
        VStack {
            Image(uiImage: roundedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding()

            HStack {
                Text("Radius")
                    .fixedSize()
                Slider(value: $cornerRadius, in: 0...150)
                Text(String(format: "%.2f", cornerRadius))
                    .frame(width: 80, alignment: .trailing)
                    .monospacedDigit()
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Image Rounding")
    }
}

#Preview {
    RoundingView()
}
