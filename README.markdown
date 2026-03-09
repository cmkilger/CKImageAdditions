# CKImageAdditions

CKImageAdditions is a collection of additional functions and methods for working with Core Graphics and UIImages on iOS.

## Features

* Blend one image over another using various blend modes
* Adjust hue, saturation, and lightness
* Resize to fit a CGSize using any content mode (except redraw)
* Round corners
* Trim sides based on transparency or a specific color
* Create a bitmap CGContext from a CGImage
* Get the average color within a specified radius of a pixel

## Installation

Add the package to your project using Swift Package Manager:

```
https://github.com/cmkilger/CKImageAdditions
```

## Usage

```swift
import CKImageAdditions

// Blend images
let blended = baseImage.blending(with: overlayImage, blendMode: .multiply)

// Adjust colors
let adjusted = image.adjustingHue(0.5, saturation: 1.0, lightness: 0.0)

// Resize
let resized = image.resizing(to: CGSize(width: 100, height: 100), contentMode: .scaleAspectFit)

// Round corners
let rounded = image.roundingCorners(withRadius: 10)

// Trim transparency
let trimmed = image.trimmingTransparency()
```

See the Examples app for more demonstrations.
