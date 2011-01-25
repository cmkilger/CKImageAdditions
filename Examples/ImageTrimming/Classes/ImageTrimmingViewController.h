//
//  ImageTrimmingViewController.h
//  ImageTrimming
//
//  Created by Cory Kilger on 1/24/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTrimmingViewController : UIViewController {
	UIImage * image;
	UIImageView * imageView;
}

@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) IBOutlet UIImageView * imageView;

- (IBAction) trim;

@end

