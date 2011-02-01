//
//  ImageColoringAppDelegate.h
//  ImageColoring
//
//  Created by Cory Kilger on 2/1/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageColoringViewController;

@interface ImageColoringAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow * window;
    ImageColoringViewController * viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow * window;
@property (nonatomic, retain) IBOutlet ImageColoringViewController * viewController;

@end

