//
//  BlendingView.swift
//  Examples
//
//  Created by Cory Kilger on 9/9/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

import SwiftUI
import CKImageAdditions

fileprivate struct BlendMode: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let mode: CGBlendMode

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: BlendMode, rhs: BlendMode) -> Bool {
        lhs.id == rhs.id
    }
}

struct BlendingView: View {
    private let bottomImage = UIImage(named: "poison_shield")!
    private let topImage = UIImage(named: "red_shield_overlay")!

    private let blendModes: [BlendMode] = [
        BlendMode(name: "Normal", mode: .normal),
        BlendMode(name: "Multiply", mode: .multiply),
        BlendMode(name: "Screen", mode: .screen),
        BlendMode(name: "Overlay", mode: .overlay),
        BlendMode(name: "Darken", mode: .darken),
        BlendMode(name: "Lighten", mode: .lighten),
        BlendMode(name: "Color Dodge", mode: .colorDodge),
        BlendMode(name: "Color Burn", mode: .colorBurn),
        BlendMode(name: "Soft Light", mode: .softLight),
        BlendMode(name: "Hard Light", mode: .hardLight),
        BlendMode(name: "Difference", mode: .difference),
        BlendMode(name: "Exclusion", mode: .exclusion),
        BlendMode(name: "Hue", mode: .hue),
        BlendMode(name: "Saturation", mode: .saturation),
        BlendMode(name: "Color", mode: .color),
        BlendMode(name: "Luminosity", mode: .luminosity),
        BlendMode(name: "Clear", mode: .clear),
        BlendMode(name: "Copy", mode: .copy),
        BlendMode(name: "Source In", mode: .sourceIn),
        BlendMode(name: "Source Out", mode: .sourceOut),
        BlendMode(name: "Source Atop", mode: .sourceAtop),
        BlendMode(name: "Destination Over", mode: .destinationOver),
        BlendMode(name: "Destination In", mode: .destinationIn),
        BlendMode(name: "Destination Out", mode: .destinationOut),
        BlendMode(name: "Destination Atop", mode: .destinationAtop),
        BlendMode(name: "XOR", mode: .xor),
        BlendMode(name: "Plus Darker", mode: .plusDarker),
        BlendMode(name: "Plus Lighter", mode: .plusLighter),
    ]

    @State private var selectedMode: BlendMode

    init() {
        let modes: [BlendMode] = [
            BlendMode(name: "Normal", mode: .normal),
            BlendMode(name: "Multiply", mode: .multiply),
            BlendMode(name: "Screen", mode: .screen),
            BlendMode(name: "Overlay", mode: .overlay),
            BlendMode(name: "Darken", mode: .darken),
            BlendMode(name: "Lighten", mode: .lighten),
            BlendMode(name: "Color Dodge", mode: .colorDodge),
            BlendMode(name: "Color Burn", mode: .colorBurn),
            BlendMode(name: "Soft Light", mode: .softLight),
            BlendMode(name: "Hard Light", mode: .hardLight),
            BlendMode(name: "Difference", mode: .difference),
            BlendMode(name: "Exclusion", mode: .exclusion),
            BlendMode(name: "Hue", mode: .hue),
            BlendMode(name: "Saturation", mode: .saturation),
            BlendMode(name: "Color", mode: .color),
            BlendMode(name: "Luminosity", mode: .luminosity),
            BlendMode(name: "Clear", mode: .clear),
            BlendMode(name: "Copy", mode: .copy),
            BlendMode(name: "Source In", mode: .sourceIn),
            BlendMode(name: "Source Out", mode: .sourceOut),
            BlendMode(name: "Source Atop", mode: .sourceAtop),
            BlendMode(name: "Destination Over", mode: .destinationOver),
            BlendMode(name: "Destination In", mode: .destinationIn),
            BlendMode(name: "Destination Out", mode: .destinationOut),
            BlendMode(name: "Destination Atop", mode: .destinationAtop),
            BlendMode(name: "XOR", mode: .xor),
            BlendMode(name: "Plus Darker", mode: .plusDarker),
            BlendMode(name: "Plus Lighter", mode: .plusLighter),
        ]
        _selectedMode = State(initialValue: modes[0])
    }

    private var blendedImage: UIImage {
        UIImage(byBlendingImage: topImage, over: bottomImage, with: selectedMode.mode, offset: CGPoint(x: -2, y: -2))
    }

    var body: some View {
        VStack {
            Image(uiImage: blendedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding()

            Picker("Blend Mode", selection: $selectedMode) {
                ForEach(blendModes) { mode in
                    Text(mode.name).tag(mode)
                }
            }
            .pickerStyle(.wheel)
        }
        .navigationTitle("Image Blending")
    }
}

#Preview {
    BlendingView()
}
