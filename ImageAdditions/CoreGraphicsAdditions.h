/*  Created by Cory Kilger on 9/10/10.
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

#ifndef COREGRAPTHICSADDITIONS_H_
#define COREGRAPTHICSADDITIONS_H_

#include <CoreGraphics/CoreGraphics.h>

/*!
    @function
    @abstract   Creates a bitmap context from an image.
    @discussion This function is used to create a context from an image.  This is typically used to manipulate the image data.
    @param      image The image from which to create a context.
    @result     Returns a bitmap context which contains the image.
*/
CGContextRef CGBitmapContextCreateWithImage(CGImageRef image);

/*!
 @function
 @abstract   Creates a new image by bending one image on top of another.
 @discussion This function first draws the bottom image normally, then the top image using the specified blend mode and offset.
 @param      bottom The bottom image.
 @param      top The top image.
 @param      blendMode The blend mode used to draw the top image.
 @param      offset The offset of the top image in relation to the bottom image.
 @result     Returns a CGImageRef of the resulting image.
 */
CGImageRef CGImageCreateByBlendingImages(CGImageRef bottom, CGImageRef top, CGBlendMode blendMode, CGPoint offset);

#endif