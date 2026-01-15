//
//  ColoringView.swift
//  Examples
//
//  Created by Cory Kilger on 2/1/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

import SwiftUI
import CKImageAdditions

struct ColoringView: View {
    private let sourceImage = UIImage(named: "prince_angry")!

    @State private var hue: Float = 0
    @State private var saturation: Float = 0
    @State private var lightness: Float = 0
    @State private var averageColorRadius: Float = 50
    @State private var sampleCenter: CGPoint?

    private var adjustedImage: UIImage {
        sourceImage.adjustingHue(CGFloat(hue), saturation: CGFloat(saturation), lightness: CGFloat(lightness))
    }

    private var currentSampleCenter: CGPoint {
        sampleCenter ?? CGPoint(x: sourceImage.size.width / 2, y: sourceImage.size.height / 2)
    }

    private var averageColor: Color {
        let uiColor = adjustedImage.averageColor(atPixel: currentSampleCenter, radius: CGFloat(averageColorRadius))
        return Color(uiColor ?? .clear)
    }

    var body: some View {
        VStack(spacing: 16) {
            ZStack {
                Image(uiImage: adjustedImage)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                sampleCenter = value.location
                            }
                    )

                ColoringCircleOverlay(center: currentSampleCenter, radius: CGFloat(averageColorRadius))
            }
            .frame(width: sourceImage.size.width, height: sourceImage.size.height)

            VStack(spacing: 12) {
                HStack {
                    Text("Hue")
                        .frame(width: 80, alignment: .leading)
                    Slider(value: $hue, in: -180...180)
                    Text(String(format: "%.1f", hue))
                        .frame(width: 80, alignment: .trailing)
                        .monospacedDigit()
                }

                HStack {
                    Text("Saturation")
                        .frame(width: 80, alignment: .leading)
                    Slider(value: $saturation, in: -100...100)
                    Text(String(format: "%.1f", saturation))
                        .frame(width: 80, alignment: .trailing)
                        .monospacedDigit()
                }

                HStack {
                    Text("Lightness")
                        .frame(width: 80, alignment: .leading)
                    Slider(value: $lightness, in: -100...100)
                    Text(String(format: "%.1f", lightness))
                        .frame(width: 80, alignment: .trailing)
                        .monospacedDigit()
                }

                HStack {
                    Text("Radius")
                        .frame(width: 80, alignment: .leading)
                    Slider(value: $averageColorRadius, in: 0...100)
                    Text(String(format: "%.1f", averageColorRadius))
                        .frame(width: 80, alignment: .trailing)
                        .monospacedDigit()
                }

                HStack {
                    Text("Average Color")
                        .lineLimit(1)
                        .fixedSize()
                    Spacer()
                    Rectangle()
                        .fill(averageColor)
                        .frame(width: 60, height: 30)
                        .border(Color.black)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
        .navigationTitle("Image Coloring")
    }
}

fileprivate struct ColoringCircleOverlay: View {
    let center: CGPoint
    let radius: CGFloat

    var body: some View {
        Canvas { context, size in
            let circlePath = Path(ellipseIn: CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: radius * 2,
                height: radius * 2
            ))
            context.stroke(circlePath, with: .color(.black), lineWidth: 1)

            var crosshairPath = Path()
            crosshairPath.move(to: CGPoint(x: center.x - 10, y: center.y))
            crosshairPath.addLine(to: CGPoint(x: center.x + 10, y: center.y))
            crosshairPath.move(to: CGPoint(x: center.x, y: center.y - 10))
            crosshairPath.addLine(to: CGPoint(x: center.x, y: center.y + 10))
            context.stroke(crosshairPath, with: .color(.black), lineWidth: 1)
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    ColoringView()
}
