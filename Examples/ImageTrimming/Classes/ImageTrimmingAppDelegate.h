//
//  ImageTrimmingAppDelegate.h
//  ImageTrimming
//
//  Created by Cory Kilger on 1/24/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageTrimmingViewController;

@interface ImageTrimmingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ImageTrimmingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ImageTrimmingViewController *viewController;

@end

