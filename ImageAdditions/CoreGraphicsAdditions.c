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

#define kNumberOfComponents (4)
#define kBytesPerComponent (8)
#define kBytesPerPixel (kNumberOfComponents)

typedef struct Pixel { uint8_t r, g, b, a; } Pixel;

#pragma mark -
#pragma mark Contexts

CGContextRef CKBitmapContextCreate(CGSize size) {
	return CKBitmapContextAndDataCreate(size, NULL);
}

CGContextRef CKBitmapContextAndDataCreate(CGSize size, void ** data) {
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if(colorSpace == NULL) {
		printf("Error allocating color space.\n");
		return NULL;
	}
	
	uint8_t *bitmapData = NULL;
    if (data)
    {
        bitmapData = (uint8_t *)calloc((size_t)(size.width * size.height * kNumberOfComponents), sizeof(uint8_t));
        *data = bitmapData;
    }
    
	CGContextRef context = CGBitmapContextCreate(bitmapData,
												 (size_t)size.width,
												 (size_t)size.height,
												 kBytesPerComponent,
												 (size_t)size.width * kBytesPerPixel,
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
	return CKBitmapContextAndDataCreateWithImage(image, NULL);
}

CGContextRef CKBitmapContextAndDataCreateWithImage(CGImageRef image, void ** data) {
	// Dimensions
	size_t width = CGImageGetWidth(image);
	size_t height = CGImageGetHeight(image);
	
	// Create context
	CGContextRef context = CKBitmapContextAndDataCreate(CGSizeMake(width, height), data);
	
	// Draw image
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
	
	return context;
}

#pragma mark -
#pragma mark Paths

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

#pragma mark -
#pragma mark Blending

CGImageRef CKImageCreateByBlendingImages(CGImageRef bottom, CGImageRef top, CGBlendMode blendMode, CGPoint offset) {
	// Dimensions
	CGRect bottomFrame = CGRectMake(0, 0, CGImageGetWidth(bottom), CGImageGetHeight(bottom));
	CGRect topFrame = CGRectMake(offset.x, offset.y, CGImageGetWidth(top), CGImageGetHeight(top));
	CGRect renderFrame = CGRectIntegral(CGRectUnion(bottomFrame, topFrame));
		
	// Create context
	void * data = NULL;
	CGContextRef context = CKBitmapContextAndDataCreate(renderFrame.size, &data);
	
	// Draw images
	CGContextSetBlendMode(context, kCGBlendModeNormal);
	CGContextDrawImage(context, CGRectOffset(bottomFrame, -renderFrame.origin.x, -renderFrame.origin.y), bottom);
	CGContextSetBlendMode(context, blendMode);
	CGContextDrawImage(context, CGRectOffset(topFrame, -renderFrame.origin.x, -renderFrame.origin.y), top);
	
	// Create image from context
	CGImageRef image = CGBitmapContextCreateImage(context);
	
	// Cleanup
	CGContextRelease(context);
	free(data);
	
	return image;
}

#pragma mark -
#pragma mark Trimming

CGImageRef CKImageCreateByTrimmingTransparency(CGImageRef image, CKImageTrimmingSides sides) {
	if (sides == CKImageTrimmingSidesNone)
		return NULL;
	
	void * bitmapData = NULL;
	CGContextRef context = CKBitmapContextAndDataCreateWithImage(image, &bitmapData);
	
	Pixel *data = bitmapData;
		
	size_t width = CGBitmapContextGetWidth(context);
	size_t height = CGBitmapContextGetHeight(context);
	
	size_t top = 0;
	size_t bottom = height;
	size_t left = 0;
	size_t right = width;
	
	// Scan the left
	if (sides & CKImageTrimmingSidesLeft) {
		for (size_t x = 0; x < width; x++) {
			for (size_t y = 0; y < height; y++) {
                Pixel pixel = data[y * width + x];
                
                if (pixel.a != 0x00) {
					left = x;
					goto SCAN_TOP;
				}
			}
		}
	}
	
	// Scan the top
SCAN_TOP:
	if (sides & CKImageTrimmingSidesTop) {
		for (size_t y = 0; y < height; y++) {
			for (size_t x = 0; x < width; x++) {
                Pixel pixel = data[y * width + x];
                
                if (pixel.a != 0x00) {
					top = y;
					goto SCAN_RIGHT;
				}
			}
		}
	}
	
	// Scan the right
SCAN_RIGHT:
	if (sides & CKImageTrimmingSidesRight) {
		for (size_t x = width-1; x >= left; x--) {
			for (size_t y = 0; y < height; y++) {
                Pixel pixel = data[y * width + x];
                
                if (pixel.a != 0x00) {
					right = x;
					goto SCAN_BOTTOM;
				}
			}
		}
	}
	
	// Scan the bottom
SCAN_BOTTOM:
	if (sides & CKImageTrimmingSidesBottom) {
		for (size_t y = height-1; y >= top; y--) {
			for (size_t x = 0; x < width; x++) {
                Pixel pixel = data[y * width + x];
                
                if (pixel.a != 0x00) {
					bottom = y;
					goto FINISH;
				}
			}
		}
	}
	
FINISH:
	CGContextRelease(context);
	free(bitmapData);
	
	void * newData = NULL;
	CGContextRef newContext = CKBitmapContextAndDataCreate(CGSizeMake(right-left+1, bottom-top+1), &newData);
	CGRect rect = CGRectMake(-1.0*left, -1.0*(height-bottom), width, height);
	CGContextDrawImage(newContext, rect, image);
	CGImageRef newImage = CGBitmapContextCreateImage(newContext);
	CGContextRelease(newContext);
	free(newData);
	
	return newImage;
}

CGImageRef CKImageCreateByTrimmingColor(CGImageRef image, CGColorRef color, CKImageTrimmingSides sides) {
	if (sides == CKImageTrimmingSidesNone)
		return NULL;
	
	if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB)
		return NULL;
	
	void * bitmapData = NULL;
	CGContextRef context = CKBitmapContextAndDataCreateWithImage(image, &bitmapData);
	
	UInt32 * data = bitmapData;
	
	const CGFloat * cgComponents = CGColorGetComponents(color);
	UInt32 colorValue = (((UInt8)(cgComponents[0]*255)) << 24) + (((UInt8)(cgComponents[1]*255)) << 16) + (((UInt8)(cgComponents[2]*255)) << 8) + (((UInt8)(cgComponents[3]*255)) << 0);
	
	size_t width = CGBitmapContextGetWidth(context);
	size_t height = CGBitmapContextGetHeight(context);
	
	size_t top = 0;
	size_t bottom = height;
	size_t left = 0;
	size_t right = width;
	
	// Scan the left
	if (sides & CKImageTrimmingSidesLeft) {
		for (size_t x = 0; x < width; x++) {
			for (size_t y = 0; y < height; y++) {
				if (data[y*width+x] != colorValue) {
					left = x;
					goto SCAN_TOP;
				}
			}
		}
	}
	
	// Scan the top
SCAN_TOP:
	if (sides & CKImageTrimmingSidesTop) {
		for (size_t y = 0; y < height; y++) {
			for (size_t x = 0; x < width; x++) {
				if (data[y*width+x] != colorValue) {
					top = y;
					goto SCAN_RIGHT;
				}
			}
		}
	}
	
	// Scan the right
SCAN_RIGHT:
	if (sides & CKImageTrimmingSidesRight) {
		for (size_t x = width-1; x >= left; x--) {
			for (size_t y = 0; y < height; y++) {
				if (data[y*width+x] != colorValue) {
					right = x;
					goto SCAN_BOTTOM;
				}
			}
		}
	}
	
	// Scan the bottom
SCAN_BOTTOM:
	if (sides & CKImageTrimmingSidesBottom) {
		for (size_t y = height-1; y >= top; y--) {
			for (size_t x = 0; x < width; x++) {
				if (data[y*width+x] != colorValue) {
					bottom = y;
					goto FINISH;
				}
			}
		}
	}
	
FINISH:
	CGContextRelease(context);
	free(bitmapData);
	
	void * newData = NULL;
	CGContextRef newContext = CKBitmapContextAndDataCreate(CGSizeMake(right-left+1, bottom-top+1), &newData);
	CGRect rect = CGRectMake(-1.0*left, -1.0*(height-bottom), width, height);
	CGContextDrawImage(newContext, rect, image);
	CGImageRef newImage = CGBitmapContextCreateImage(newContext);
	CGContextRelease(newContext);
	free(newData);
	
	return newImage;
}

#endif