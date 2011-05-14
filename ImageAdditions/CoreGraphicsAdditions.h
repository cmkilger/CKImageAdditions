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

#pragma mark -
#pragma mark Contexts

/*!
 @function
 @abstract   Creates a bitmap context with default settings.
 @discussion This function is used to create a 32-bit RGBA bitmap context.
 @param      image The image from which to create a context.
 @result     Returns a bitmap context which contains the image.
 */
CGContextRef CKBitmapContextCreate(CGSize size) CG_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);

/*!
 @function
 @abstract   Creates a bitmap context with default settings.
 @discussion This function is used to create a 32-bit RGBA bitmap context.
 @param      image The image from which to create a context.
 @param      data Pass in the address of a void *. Upon return the void * will contain the address of the bitmap data. This data should be free'd at the same time as releasing the context. Passing NULL behaves the same as CKBitmapContextCreate().
 @result     Returns a bitmap context which contains the image and the bitmap data by reference.
 */
CGContextRef CKBitmapContextAndDataCreate(CGSize size, void ** data) CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);

/*!
 @function
 @abstract   Creates a bitmap context from an image.
 @discussion This function is used to create a context from an image.  This is typically used to manipulate the image data.
 @param      image The image from which to create a context.
 @result     Returns a bitmap context which contains the image.
 */
CGContextRef CKBitmapContextCreateWithImage(CGImageRef image) CG_AVAILABLE_STARTING(__MAC_10_6, __IPHONE_4_0);

/*!
 @function
 @abstract   Creates a bitmap context from an image.
 @discussion This function is used to create a context from an image.  This is typically used to manipulate the image data.
 @param      image The image from which to create a context.
 @param      data Pass in the address of a void *. Upon return the void * will contain the address of the bitmap data. This data should be free'd at the same time as releasing the context. Passing NULL behaves the same as CKBitmapContextCreateWithImage().
 @result     Returns a bitmap context which contains the image and the bitmap data by reference.
 */
CGContextRef CKBitmapContextAndDataCreateWithImage(CGImageRef image, void ** data) CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

#pragma mark -
#pragma mark Paths

CGPathRef CKPathCreateWithRoundedRect(CGRect rect, CGFloat radius) CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

#pragma mark -
#pragma mark Blending

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
CGImageRef CKImageCreateByBlendingImages(CGImageRef bottom, CGImageRef top, CGBlendMode blendMode, CGPoint offset) CG_AVAILABLE_STARTING(__MAC_10_4, __IPHONE_2_0);

#pragma mark -
#pragma mark Trimming

typedef enum {
	CKImageTrimmingSidesNone   = 0,
	CKImageTrimmingSidesTop    = 1 << 0,
	CKImageTrimmingSidesBottom = 1 << 1,
	CKImageTrimmingSidesLeft   = 1 << 2,
	CKImageTrimmingSidesRight  = 1 << 3,
	CKImageTrimmingSidesAll    = 0xF,
} CKImageTrimmingSides;

CGImageRef CKImageCreateByTrimmingTransparency(CGImageRef image, CKImageTrimmingSides sides) CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);
CGImageRef CKImageCreateByTrimmingColor(CGImageRef image, CGColorRef color, CKImageTrimmingSides sides) CG_AVAILABLE_STARTING(__MAC_10_2, __IPHONE_2_0);

#endif