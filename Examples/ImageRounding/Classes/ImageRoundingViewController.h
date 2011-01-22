//
//  ImageRoundingViewController.h
//  ImageRounding
//
//  Created by Cory Kilger on 1/21/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageRoundingViewController : UIViewController {
	UIImage * image;
	UIImageView * imageView;
	UILabel * label;
	UISlider * slider;
}

@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UILabel * label;
@property (nonatomic, retain) IBOutlet UISlider * slider;

- (IBAction) sliderChanged;

@end

