//
//  ImageColoringCircleOverlay.h
//  ImageColoring
//
//  Created by Cory Kilger on 5/25/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageColoringViewController;

@interface ImageColoringCircleOverlay : UIView

@property (nonatomic, assign) IBOutlet ImageColoringViewController * viewController;
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;

@end
