/*  Created by Cory Kilger on 9/13/10.
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

#import <UIKit/UIGraphics.h>
#import <UIKit/UIScreen.h>

#import "UIImage+ImageResizing.h"
#import "UIKitAdditions.h"


@implementation UIImage (Resizing)

- (UIImage *) imageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
	CGImageRef imgRef = self.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	CGFloat xScaleRatio = 1.0;
	CGFloat yScaleRatio = 1.0;
	if ([self respondsToSelector:@selector(scale)]) {
		xScaleRatio /= [self scale];
		yScaleRatio /= [self scale];
	}
	CGPoint origin = CGPointZero;
	
	switch (contentMode) {
		case UIViewContentModeScaleToFill: {
			xScaleRatio = size.width/width;
			yScaleRatio = size.height/height;
			origin = CGPointMake(((size.width/xScaleRatio)-width)/2, ((size.height/yScaleRatio)-height)/2);
		} break;
			
		case UIViewContentModeScaleAspectFit: {
			xScaleRatio = fminf(size.width/width, size.height/height);
			yScaleRatio = xScaleRatio;
			origin = CGPointMake(((size.width/xScaleRatio)-width)/2, ((size.height/yScaleRatio)-height)/2);
		} break;
			
		case UIViewContentModeScaleAspectFill: {
			xScaleRatio = fmaxf(size.width/width, size.height/height);
			yScaleRatio = xScaleRatio;
			origin = CGPointMake(((size.width/xScaleRatio)-width)/2, ((size.height/yScaleRatio)-height)/2);
		} break;
			
		case UIViewContentModeCenter: {
			origin = CGPointMake(((size.width/xScaleRatio)-width)/2, ((size.height/yScaleRatio)-height)/2);
		} break;
			
		case UIViewContentModeTop: {
			origin = CGPointMake(((size.width/xScaleRatio)-width)/2, ((size.height/yScaleRatio)-height));
		} break;
			
		case UIViewContentModeBottom: {
			origin = CGPointMake(((size.width/xScaleRatio)-width)/2, 0);
		} break;
			
		case UIViewContentModeLeft: {
			origin = CGPointMake(0, ((size.height/yScaleRatio)-height)/2);
		} break;
			
		case UIViewContentModeRight: {
			origin = CGPointMake(((size.width/xScaleRatio)-width), ((size.height/yScaleRatio)-height)/2);
		} break;
			
		case UIViewContentModeTopLeft: {
			origin = CGPointMake(0, ((size.height/yScaleRatio)-height));
		} break;
			
		case UIViewContentModeTopRight: {
			origin = CGPointMake(((size.width/xScaleRatio)-width), ((size.height/yScaleRatio)-height));
		} break;
			
		case UIViewContentModeBottomLeft: {
		} break;
			
		case UIViewContentModeBottomRight: {
			origin = CGPointMake(((size.width/xScaleRatio)-width), 0);
		} break;
			
		default:
			[NSException raise:@"CKUnimplementedContentModeException" format:@"The specified content mode has not been implemented."];
			break;
	}
	
	CGContextRef context = CKGraphicsImageContextCreateWithOptions(size, 0);
	CGContextScaleCTM(context, xScaleRatio, yScaleRatio);
	CGContextDrawImage(context, CGRectMake(origin.x, origin.y, width, height), imgRef);
	
	UIImage * image = CKGraphicsGetImageFromImageContext(context, 0);
	
	CGContextRelease(context);
	
	return image;
}

@end
