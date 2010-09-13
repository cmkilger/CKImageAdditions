//
//  ImageBlendingAppDelegate.h
//  ImageBlending
//
//  Created by Cory Kilger on 9/9/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageBlendingViewController;

@interface ImageBlendingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ImageBlendingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ImageBlendingViewController *viewController;

@end

