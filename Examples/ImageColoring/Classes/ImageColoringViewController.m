//
//  ImageColoringViewController.m
//  ImageColoring
//
//  Created by Cory Kilger on 2/1/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import "ImageColoringViewController.h"
#import "CKImageAdditions.h"
#import "ImageColoringCircleOverlay.h"

@implementation ImageColoringViewController

@synthesize image, imageView;
@synthesize hueLabel, hueSlider;
@synthesize saturationLabel, saturationSlider;
@synthesize lightnessLabel, lightnessSlider;
@synthesize averageColorLabel, averageColorSlider, averageColorView;
@synthesize overlay;

- (void) awakeFromNib {
	self.image = [UIImage imageNamed:@"prince_angry.png"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)viewDidLoad {
	[self sliderChanged];
}

- (void) viewDidUnload {
	[super viewDidUnload];
	self.imageView = nil;
	self.hueLabel = nil;
	self.hueSlider = nil;
	self.saturationLabel = nil;
	self.saturationSlider = nil;
	self.lightnessLabel = nil;
	self.lightnessSlider = nil;
	self.averageColorLabel = nil;
	self.averageColorSlider = nil;
	self.averageColorView = nil;
	self.overlay = nil;
}

- (void)dealloc {
	[image release];
	[imageView release];
	[hueLabel release];
	[hueSlider release];
	[saturationLabel release];
	[saturationSlider release];
	[lightnessLabel release];
	[lightnessSlider release];
	[averageColorLabel release];
	[averageColorSlider release];
	[averageColorView release];
	[overlay release];
    [super dealloc];
}

#pragma mark -

- (IBAction) sliderChanged {
	hueLabel.text = [NSString stringWithFormat:@"%.1f", hueSlider.value];
	saturationLabel.text = [NSString stringWithFormat:@"%.1f", saturationSlider.value];
	lightnessLabel.text = [NSString stringWithFormat:@"%.1f", lightnessSlider.value];
	averageColorLabel.text = [NSString stringWithFormat:@"%.1f", averageColorSlider.value];
	imageView.image = [image imageByAdjustingHue:hueSlider.value saturation:saturationSlider.value lightness:lightnessSlider.value];
	overlay.radius = averageColorSlider.value;
	averageColorView.backgroundColor = [imageView.image averageColorAtPixel:overlay.center radius:overlay.radius];
}

@end
