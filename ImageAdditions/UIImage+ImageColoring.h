/*  Created by Cory Kilger on 2/1/11.
 *
 *	Copyright (c) 2010 Cory Kilger.
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy
 *	of this software and associated documentation files (the "Software"), to deal
 *	in the Software without restriction, including without limitation the rights
 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *	copies of the Software, and to permit persons to whom the Software is
 *	furnished to do so, subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in
 *	all copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *	THE SOFTWARE.
 */

#import <UIKit/UIImage.h>

@interface UIImage (ImageColoring)

/*!
 @method     
 @abstract   Creates a new image by adjusting the hue, saturation and lightness
 @param      hue         The ammount to adjust the hue, in degrees.
 @param      saturation  The ammount to adjust the saturation, +/- 100.
 @param      lightness   The ammount to adjust the lightness, +/- 100.
 @return     The adjusted image.
 */
- (UIImage *) imageByAdjustingHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness;

/*!
 @method     
 @abstract   Averages the colors in a circular area of an image.
 @param      pixel       The center point of the circle
 @param      radius      The radius of the circle
 @return     The average color
 */
- (UIColor *) averageColorAtPixel:(CGPoint)pixel radius:(CGFloat)radius;

@end
