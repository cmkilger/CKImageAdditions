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

- (UIImage *) imageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
	CGImageRef imgRef = self.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);
	
	CGFloat xScaleRatio = 0.0;
	CGFloat yScaleRatio = 0.0;
	CGPoint origin = CGPointZero;
	
	switch (contentMode) {
		case UIViewContentModeScaleAspectFit: {
			xScaleRatio = fminf(size.width/width, size.height/height);
			yScaleRatio = xScaleRatio;
			origin = CGPointMake(((size.width/xScaleRatio)-width)/2, ((size.height/xScaleRatio)-height)/2);
		} break;
			
		case UIViewContentModeScaleAspectFill: {
			xScaleRatio = fmaxf(size.width/width, size.height/height);
			yScaleRatio = xScaleRatio;
			origin = CGPointMake(((size.width/xScaleRatio)-width)/2, ((size.height/xScaleRatio)-height)/2);
		} break;
			
		default:
			[NSException raise:@"CKUnimplementedContentModeException" format:@"The specified content mode has not yet been implemented."];
			break;
	}
	
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextScaleCTM(context, xScaleRatio, -yScaleRatio);
	CGContextDrawImage(context, CGRectMake(origin.x, -(origin.y+height), width, height), imgRef);
	
	UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return image;
}

@end
