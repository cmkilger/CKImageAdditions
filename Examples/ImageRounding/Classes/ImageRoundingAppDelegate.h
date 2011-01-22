//
//  ImageRoundingAppDelegate.h
//  ImageRounding
//
//  Created by Cory Kilger on 1/21/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageRoundingViewController;

@interface ImageRoundingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ImageRoundingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ImageRoundingViewController *viewController;

@end

