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

## License

CKImageAdditions is licensed under the MIT license, which is reproduced in its entirety here:

>Copyright (c) 2010 Cory Kilger
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in
>all copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>THE SOFTWARE.
