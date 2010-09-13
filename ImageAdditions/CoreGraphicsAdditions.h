/*
 *  CGImageAdditions.h
 *  ImageBlending
 *
 *  Created by Cory Kilger on 9/10/10.
 *  Copyright 2010 Cory Kilger. All rights reserved.
 *
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