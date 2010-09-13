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

#import "UIImage+ImageResizing.h"


@implementation UIImage (Resizing)

- (UIImage *) aspectFittedImageForSize:(CGSize)size {
	CGImageRef imgRef = self.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	CGFloat scaleRatio = fminf(size.width/width, size.height/height);
	CGPoint origin = CGPointMake((size.width-(width*scaleRatio))/2, (size.height-(height*scaleRatio))/2);
	
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextScaleCTM(context, scaleRatio, -scaleRatio);
	CGContextDrawImage(context, CGRectMake(origin.x, origin.y-height, width, height), imgRef);
	
	UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return image;
}

- (UIImage *) aspectFilledImageForSize:(CGSize)size {
	CGImageRef imgRef = self.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	CGFloat scaleRatio = fmaxf(size.width/width, size.height/height);
	CGPoint origin = CGPointMake((size.width-(width*scaleRatio))/2, (size.height-(height*scaleRatio))/2);
	
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextScaleCTM(context, scaleRatio, -scaleRatio);
	CGContextDrawImage(context, CGRectMake(origin.x, origin.y-height, width, height), imgRef);
	
	UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return image;
}

@end
