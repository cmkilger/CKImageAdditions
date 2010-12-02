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

CGContextRef CKBitmapContextCreate(CGSize size) {
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if(colorSpace == NULL) {
		printf("Error allocating color space.\n");
		return NULL;
	}
	
	CGContextRef context = CGBitmapContextCreate(NULL,
												 size.width,
												 size.height,
												 8,
												 size.width * 4,
												 colorSpace,
												 kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(colorSpace);
	
	if(context == NULL) {
		printf("Context not created!\n");
		return NULL;
	}
	
	return context;
}

CGContextRef CKBitmapContextCreateWithImage(CGImageRef image) {
	// Dimensions
	size_t width = CGImageGetWidth(image);
	size_t height = CGImageGetHeight(image);
	
	// Create context
	CGContextRef context = CKBitmapContextCreate(CGSizeMake(width, height));
	
	// Draw image
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
	
	return context;
}

CGImageRef CKImageCreateByBlendingImages(CGImageRef bottom, CGImageRef top, CGBlendMode blendMode, CGPoint offset) {
	// Dimensions
	CGRect bottomFrame = CGRectMake(0, 0, CGImageGetWidth(bottom), CGImageGetHeight(bottom));
	CGRect topFrame = CGRectMake(offset.x, offset.y, CGImageGetWidth(top), CGImageGetHeight(top));
	CGRect renderFrame = CGRectIntegral(CGRectUnion(bottomFrame, topFrame));
		
	// Create context
	CGContextRef context = CKBitmapContextCreate(renderFrame.size);
	
	// Draw images
	CGContextSetBlendMode(context, kCGBlendModeNormal);
	CGContextDrawImage(context, CGRectOffset(bottomFrame, -renderFrame.origin.x, -renderFrame.origin.y), bottom);
	CGContextSetBlendMode(context, blendMode);
	CGContextDrawImage(context, CGRectOffset(topFrame, -renderFrame.origin.x, -renderFrame.origin.y), top);
	
	// Create image from context
	CGImageRef image = CGBitmapContextCreateImage(context);
	
	// Cleanup
	CGContextRelease(context);
	
	return image;
}

CGPathRef CKPathCreateWithRoundedRect(CGRect rect, CGFloat radius) {
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect)+radius, CGRectGetMinY(rect));
	CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect)-radius, CGRectGetMinY(rect));
	CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect)+radius, radius);
	CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect)-radius);
	CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMaxX(rect)-radius, CGRectGetMaxY(rect), radius);
	CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect)+radius, CGRectGetMaxY(rect));
	CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect)-radius, radius);
	CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect)+radius);
	CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMinX(rect)+radius, CGRectGetMinY(rect), radius);
	return path;
}

#endif