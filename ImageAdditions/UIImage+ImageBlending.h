//
//  UIImage+ImageBlending.h
//  ImageBlending
//
//  Created by Cory Kilger on 9/9/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

#import <UIKit/UIImage.h>

@interface UIImage (ImageBlending)

+ (UIImage *) imageByBlendingImage:(UIImage *)top over:(UIImage *)bottom withMode:(CGBlendMode)blendMode;
+ (UIImage *) imageByBlendingImage:(UIImage *)top over:(UIImage *)bottom withMode:(CGBlendMode)blendMode offset:(CGPoint)offset;

@end
