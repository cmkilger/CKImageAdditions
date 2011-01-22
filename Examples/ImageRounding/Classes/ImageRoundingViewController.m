//
// ImageRoundingViewController.m
// ImageRounding
//
// Created by Cory Kilger on 1/21/11.
// Copyright 2011 Cory Kilger. All rights reserved.
//

#import "ImageRoundingViewController.h"
#import "CKImageAdditions.h"

@implementation ImageRoundingViewController

@synthesize image, imageView, label, slider;

- (void) awakeFromNib {
	image = [UIImage imageNamed:@"ninja_disguise"];
}

#pragma mark Memory Management

- (void) viewDidLoad {
	[super viewDidLoad];
	[self sliderChanged];
}

- (void) viewDidUnload {
	self.imageView = nil;
	self.label = nil;
}

- (void) dealloc {
	[image release];
	[imageView release];
	[label release];
	[super dealloc];
}

#pragma mark -

- (void) sliderChanged {
	CGFloat value = [slider value];
	imageView.image = [image imageWithRoundedCorners:value];
	label.text = [NSString stringWithFormat:@"%.2f", value];
}

@end
