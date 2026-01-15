/*  Created by Cory Kilger on 10/16/10.
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

#import "UIKitAdditions.h"
#import "CoreGraphicsAdditions.h"
#import "UIImage+ImageResizing.h"

CGContextRef CKGraphicsImageContextCreateWithOptions(CGSize size, CGFloat scale) {
	if (scale == 0)
		scale = CK_SCREEN_SCALE_FACTOR;
	size = CGSizeMake(size.width*scale, size.height*scale);
	CGContextRef context = CKBitmapContextCreate(size);
	CGContextScaleCTM(context, scale, scale);
	return context;
}

UIImage * CKGraphicsGetImageFromImageContext(CGContextRef context, CGFloat scale) {
	if (scale == 0)
		scale = CK_SCREEN_SCALE_FACTOR;
	CGImageRef imageRef = CGBitmapContextCreateImage(context);
	UIImage * image = nil;
	if ([[UIImage class] respondsToSelector:@selector(imageWithCGImage:scale:orientation:)])
		image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
	else
		image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return image;
}
