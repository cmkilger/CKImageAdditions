//
//  ImageResizingAppDelegate.h
//  ImageResizing
//
//  Created by Cory Kilger on 9/13/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageResizingViewController;

@interface ImageResizingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ImageResizingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ImageResizingViewController *viewController;

@end

