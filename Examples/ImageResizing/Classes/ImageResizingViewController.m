//
//  ImageResizingViewController.m
//  ImageResizing
//
//  Created by Cory Kilger on 9/13/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ImageResizingViewController.h"
#import "CKImageAdditions.h"

@interface ScaleMode : NSObject {
	NSString * name;
	UIViewContentMode scaleMode;
}

@property (readonly, copy) NSString * name;
@property (readonly, assign) UIViewContentMode scaleMode;

+ (id) scaleModeWithName:(NSString *)newName mode:(UIViewContentMode)newScaleMode;
- (id) initWithName:(NSString *)newName mode:(UIViewContentMode)newScaleMode;

@end

@implementation ScaleMode

@synthesize name, scaleMode;

+ (id) scaleModeWithName:(NSString *)newName mode:(UIViewContentMode)newScaleMode {
	return [[[self alloc] initWithName:newName mode:newScaleMode] autorelease];
}

- (id) initWithName:(NSString *)newName mode:(UIViewContentMode)newScaleMode {
	if (![super init])
		return nil;
	name = [newName copy];
	scaleMode = newScaleMode;
	return self;
}

- (void) dealloc {
	[name release];
	[super dealloc];
}

@end

#pragma mark -

@implementation ImageResizingViewController

@synthesize image, imageView1, imageView2, picker;

- (void) awakeFromNib {
	image = [UIImage imageNamed:@"poison_shield"];
	
	scaleModes = [[NSArray alloc] initWithObjects:
				  [ScaleMode scaleModeWithName:@"Scale to Fill" mode:UIViewContentModeScaleToFill],
				  [ScaleMode scaleModeWithName:@"Aspect Fit" mode:UIViewContentModeScaleAspectFit],
				  [ScaleMode scaleModeWithName:@"Aspect Fill" mode:UIViewContentModeScaleAspectFill],
				  [ScaleMode scaleModeWithName:@"Center" mode:UIViewContentModeCenter],
				  [ScaleMode scaleModeWithName:@"Top" mode:UIViewContentModeTop],
				  [ScaleMode scaleModeWithName:@"Bottom" mode:UIViewContentModeBottom],
				  [ScaleMode scaleModeWithName:@"Left" mode:UIViewContentModeLeft],
				  [ScaleMode scaleModeWithName:@"Right" mode:UIViewContentModeRight],
				  [ScaleMode scaleModeWithName:@"Top Left" mode:UIViewContentModeTopLeft],
				  [ScaleMode scaleModeWithName:@"Top Right" mode:UIViewContentModeTopRight],
				  [ScaleMode scaleModeWithName:@"Bottom Left" mode:UIViewContentModeBottomLeft],
				  [ScaleMode scaleModeWithName:@"Bottom Right" mode:UIViewContentModeBottomRight],
				  nil];
}

#pragma mark Memory Management

- (void)viewDidLoad {
	[self pickerView:picker didSelectRow:0 inComponent:0];
	
	imageView1.layer.borderColor = [[UIColor redColor] CGColor];
	imageView1.layer.borderWidth = 1.0;
	
	imageView2.layer.borderColor = [[UIColor redColor] CGColor];
	imageView2.layer.borderWidth = 1.0;
	imageView2.image = image;
}

- (void)viewDidUnload {
	self.imageView1 = nil;
	self.imageView2 = nil;
	self.picker = nil;
}

- (void)dealloc {
	[scaleModes release];
	[image release];
	[imageView1 release];
	[imageView2 release];
	[picker release];
    [super dealloc];
}

#pragma mark Picker

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [scaleModes count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[scaleModes objectAtIndex:row] name];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	UIViewContentMode mode = [[scaleModes objectAtIndex:row] scaleMode];
	imageView1.image = [image imageWithSize:imageView1.frame.size contentMode:mode];
	imageView2.contentMode = mode;
}

@end
