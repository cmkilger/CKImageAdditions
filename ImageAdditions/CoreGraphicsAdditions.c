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

#ifndef COREGRAPTHICSADDITIONS_C_
#define COREGRAPTHICSADDITIONS_C_

#include "CoreGraphicsAdditions.h"

#include <stdlib.h>
#include <stdio.h>
#include <math.h>

CGContextRef CGBitmapContextCreateWithImage(CGImageRef image) {
	// Dimensions
	size_t width = CGImageGetWidth(image);
	size_t height = CGImageGetHeight(image);
	
	
	// Create context	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if(colorSpace == NULL) {
		printf("Error allocating color space.\n");
		return NULL;
	}
	
	CGContextRef context = CGBitmapContextCreate(NULL,
												 width,
												 height,
												 8,      // bits per component
												 width * 4,
												 colorSpace,
												 kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(colorSpace);
	
	if(context == NULL) {
		printf("Context not created!\n");
		return NULL;
	}
	
	// Draw image
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
	CGImageRelease(image);
	
	return context;
}

CGImageRef CGImageCreateByBlendingImages(CGImageRef bottom, CGImageRef top, CGBlendMode blendMode, CGPoint offset) {
	// Dimensions
	CGRect bottomFrame = CGRectMake(0, 0, CGImageGetWidth(bottom), CGImageGetHeight(bottom));
	CGRect topFrame = CGRectMake(offset.x, offset.y, CGImageGetWidth(top), CGImageGetHeight(top));
	CGRect renderFrame = CGRectIntegral(CGRectUnion(bottomFrame, topFrame));
		
	// Create context
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if(colorSpace == NULL) {
		printf("Error allocating color space.\n");
		return NULL;
	}
	
	CGContextRef context = CGBitmapContextCreate(NULL,
												 renderFrame.size.width,
												 renderFrame.size.height,
												 8,      // bits per component
												 renderFrame.size.width * 4,
												 colorSpace,
												 kCGImageAlphaPremultipliedFirst);
	CGColorSpaceRelease(colorSpace);
	
	if (context == NULL) {
		printf("Context not created!\n");
		return NULL;
	}
	
	// Draw images
	CGContextSetBlendMode(context, kCGBlendModeNormal);
	CGContextDrawImage(context, CGRectOffset(bottomFrame, -renderFrame.origin.x, -renderFrame.origin.y), bottom);
	CGContextSetBlendMode(context, blendMode);
	CGContextDrawImage(context, CGRectOffset(topFrame, -renderFrame.origin.x, -renderFrame.origin.y), top);
	
	// Create image from context
	CGImageRef blendedImage = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	return blendedImage;
}

#endif