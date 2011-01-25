//
//  ImageTrimmingViewController.m
//  ImageTrimming
//
//  Created by Cory Kilger on 1/24/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import "ImageTrimmingViewController.h"
#import "UIImage+Trimming.h"

@implementation ImageTrimmingViewController

@synthesize image, imageView;

- (void) awakeFromNib {
	self.image = [UIImage imageNamed:@"test3.png"];
}

#pragma mark -

- (void) viewDidLoad {
	[super viewDidLoad];
	imageView.image = image;
}

- (void)viewDidUnload {
	self.imageView = nil;
}

- (void)dealloc {
	[imageView release];
    [super dealloc];
}

#pragma mark -

- (IBAction) trim {
	imageView.image = [image imageByTrimmingTransparency];
}

@end
