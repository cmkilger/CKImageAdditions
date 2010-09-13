/*
 *  CGImageAdditions.c
 *  ImageBlending
 *
 *  Created by Cory Kilger on 9/10/10.
 *  Copyright 2010 Cory Kilger. All rights reserved.
 *
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
	return CGBitmapContextCreateImage(context);
}

#endif