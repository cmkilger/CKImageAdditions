//
//  ResizingView.swift
//  Examples
//
//  Created by Cory Kilger on 9/13/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

import SwiftUI
import CKImageAdditions

fileprivate struct ScaleMode: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let mode: UIView.ContentMode

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ScaleMode, rhs: ScaleMode) -> Bool {
        lhs.id == rhs.id
    }
}

struct ResizingView: View {
    private let sourceImage = UIImage(named: "poison_shield")!
    private let targetSize = CGSize(width: 100, height: 150)

    private let scaleModes: [ScaleMode] = [
        ScaleMode(name: "Scale to Fill", mode: .scaleToFill),
        ScaleMode(name: "Aspect Fit", mode: .scaleAspectFit),
        ScaleMode(name: "Aspect Fill", mode: .scaleAspectFill),
        ScaleMode(name: "Center", mode: .center),
        ScaleMode(name: "Top", mode: .top),
        ScaleMode(name: "Bottom", mode: .bottom),
        ScaleMode(name: "Left", mode: .left),
        ScaleMode(name: "Right", mode: .right),
        ScaleMode(name: "Top Left", mode: .topLeft),
        ScaleMode(name: "Top Right", mode: .topRight),
        ScaleMode(name: "Bottom Left", mode: .bottomLeft),
        ScaleMode(name: "Bottom Right", mode: .bottomRight),
    ]

    @State private var selectedMode: ScaleMode

    init() {
        let modes: [ScaleMode] = [
            ScaleMode(name: "Scale to Fill", mode: .scaleToFill),
            ScaleMode(name: "Aspect Fit", mode: .scaleAspectFit),
            ScaleMode(name: "Aspect Fill", mode: .scaleAspectFill),
            ScaleMode(name: "Center", mode: .center),
            ScaleMode(name: "Top", mode: .top),
            ScaleMode(name: "Bottom", mode: .bottom),
            ScaleMode(name: "Left", mode: .left),
            ScaleMode(name: "Right", mode: .right),
            ScaleMode(name: "Top Left", mode: .topLeft),
            ScaleMode(name: "Top Right", mode: .topRight),
            ScaleMode(name: "Bottom Left", mode: .bottomLeft),
            ScaleMode(name: "Bottom Right", mode: .bottomRight),
        ]
        _selectedMode = State(initialValue: modes[0])
    }

    private var resizedImage: UIImage {
        sourceImage.withSize(targetSize, contentMode: selectedMode.mode)
    }

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    Text("Library Resize")
                        .font(.caption)
                    Image(uiImage: resizedImage)
                        .border(Color.red)
                }

                VStack {
                    Text("UIKit ContentMode")
                        .font(.caption)
                    ResizingUIKitImageView(image: sourceImage, contentMode: selectedMode.mode)
                        .frame(width: targetSize.width, height: targetSize.height)
                        .clipped()
                        .border(Color.red)
                }
            }
            .padding()

            Picker("Scale Mode", selection: $selectedMode) {
                ForEach(scaleModes) { mode in
                    Text(mode.name).tag(mode)
                }
            }
            .pickerStyle(.wheel)

            Spacer()
        }
        .navigationTitle("Image Resizing")
    }
}

fileprivate struct ResizingUIKitImageView: UIViewRepresentable {
    let image: UIImage
    let contentMode: UIView.ContentMode

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        return imageView
    }

    func updateUIView(_ imageView: UIImageView, context: Context) {
        imageView.image = image
        imageView.contentMode = contentMode
    }
}

#Preview {
    ResizingView()
}
