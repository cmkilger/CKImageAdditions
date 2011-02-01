//
//  ImageColoringViewController.h
//  ImageColoring
//
//  Created by Cory Kilger on 2/1/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageColoringViewController : UIViewController {
	UIImage * image;
	UIImageView * imageView;
	UILabel * hueLabel;
	UISlider * hueSlider;
	UILabel * saturationLabel;
	UISlider * saturationSlider;
	UILabel * lightnessLabel;
	UISlider * lightnessSlider;
}

@property (nonatomic, retain) UIImage * image;

@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UILabel * hueLabel;
@property (nonatomic, retain) IBOutlet UISlider * hueSlider;
@property (nonatomic, retain) IBOutlet UILabel * saturationLabel;
@property (nonatomic, retain) IBOutlet UISlider * saturationSlider;
@property (nonatomic, retain) IBOutlet UILabel * lightnessLabel;
@property (nonatomic, retain) IBOutlet UISlider * lightnessSlider;

- (IBAction) sliderChanged;

@end

