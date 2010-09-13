//
//  UIImage+ImageBlending.m
//  ImageBlending
//
//  Created by Cory Kilger on 9/9/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

#import "UIImage+ImageBlending.h"
#import "CoreGraphicsAdditions.h"

@implementation UIImage (ImageBlending)

+ (UIImage *) imageByBlendingImage:(UIImage *)top over:(UIImage *)bottom withMode:(CGBlendMode)blendMode {
	return [UIImage imageByBlendingImage:top over:bottom withMode:blendMode offset:CGPointZero];
}

+ (UIImage *) imageByBlendingImage:(UIImage *)top over:(UIImage *)bottom withMode:(CGBlendMode)blendMode offset:(CGPoint)offset {
	CGImageRef imageRef = CGImageCreateByBlendingImages(bottom.CGImage, top.CGImage, blendMode, offset);
	UIImage * image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	return image;
}

@end
