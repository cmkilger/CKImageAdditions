//
//  ImageBlendingViewController.m
//  ImageBlending
//
//  Created by Cory Kilger on 9/9/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

#import "ImageBlendingViewController.h"
#import "UIImage+ImageBlending.h"

@interface BlendMode : NSObject {
	NSString * name;
	CGBlendMode blendMode;
}

@property (readonly, copy) NSString * name;
@property (readonly, assign) CGBlendMode blendMode;

+ (id) blendModeWithName:(NSString *)newName mode:(CGBlendMode)newBlendMode;
- (id) initWithName:(NSString *)newName mode:(CGBlendMode)newBlendMode;

@end

@implementation BlendMode

@synthesize name, blendMode;

+ (id) blendModeWithName:(NSString *)newName mode:(CGBlendMode)newBlendMode {
	return [[[self alloc] initWithName:newName mode:newBlendMode] autorelease];
}

- (id) initWithName:(NSString *)newName mode:(CGBlendMode)newBlendMode {
	if (![super init])
		return nil;
	name = [newName copy];
	blendMode = newBlendMode;
	return self;
}

- (void) dealloc {
	[name release];
	[super dealloc];
}

@end

#pragma mark -

@implementation ImageBlendingViewController

@synthesize image, picker;

- (void) awakeFromNib {
	bottomImage = [UIImage imageNamed:@"poison_shield"];
	topImage = [UIImage imageNamed:@"red_shield_overlay"];

	blendModes = [[NSArray alloc] initWithObjects:
				  [BlendMode blendModeWithName:@"Normal" mode:kCGBlendModeNormal],
				  [BlendMode blendModeWithName:@"Multiply" mode:kCGBlendModeMultiply],
				  [BlendMode blendModeWithName:@"Screen" mode:kCGBlendModeScreen],
				  [BlendMode blendModeWithName:@"Overlay" mode:kCGBlendModeOverlay],
				  [BlendMode blendModeWithName:@"Darken" mode:kCGBlendModeDarken],
				  [BlendMode blendModeWithName:@"Lighten" mode:kCGBlendModeLighten],
				  [BlendMode blendModeWithName:@"Color Dodge" mode:kCGBlendModeColorDodge],
				  [BlendMode blendModeWithName:@"Color Burn" mode:kCGBlendModeColorBurn],
				  [BlendMode blendModeWithName:@"Soft Light" mode:kCGBlendModeSoftLight],
				  [BlendMode blendModeWithName:@"Hard Light" mode:kCGBlendModeHardLight],
				  [BlendMode blendModeWithName:@"Difference" mode:kCGBlendModeDifference],
				  [BlendMode blendModeWithName:@"Exclusion" mode:kCGBlendModeExclusion],
				  [BlendMode blendModeWithName:@"Hue" mode:kCGBlendModeHue],
				  [BlendMode blendModeWithName:@"Saturation" mode:kCGBlendModeSaturation],
				  [BlendMode blendModeWithName:@"Color" mode:kCGBlendModeColor],
				  [BlendMode blendModeWithName:@"Luminosity" mode:kCGBlendModeLuminosity],
				  [BlendMode blendModeWithName:@"Clear" mode:kCGBlendModeClear],
				  [BlendMode blendModeWithName:@"Copy" mode:kCGBlendModeCopy],
				  [BlendMode blendModeWithName:@"Source In" mode:kCGBlendModeSourceIn],
				  [BlendMode blendModeWithName:@"Source Out" mode:kCGBlendModeSourceOut],
				  [BlendMode blendModeWithName:@"Source Atop" mode:kCGBlendModeSourceAtop],
				  [BlendMode blendModeWithName:@"Destination Over" mode:kCGBlendModeDestinationOver],
				  [BlendMode blendModeWithName:@"Destination In" mode:kCGBlendModeDestinationIn],
				  [BlendMode blendModeWithName:@"Destination Out" mode:kCGBlendModeDestinationOut],
				  [BlendMode blendModeWithName:@"Destination Atop" mode:kCGBlendModeDestinationAtop],
				  [BlendMode blendModeWithName:@"XOR" mode:kCGBlendModeXOR],
				  [BlendMode blendModeWithName:@"Plus Darker" mode:kCGBlendModePlusDarker],
				  [BlendMode blendModeWithName:@"Plus Lighter" mode:kCGBlendModePlusLighter],
				  nil];
}

#pragma mark Memory Management

- (void)viewDidLoad {
	[self pickerView:picker didSelectRow:0 inComponent:0];
}

- (void)viewDidUnload {
	self.image = nil;
	self.picker = nil;
}

- (void)dealloc {
	[blendModes release];
	[bottomImage release];
	[topImage release];
	[image release];
	[picker release];
    [super dealloc];
}

#pragma mark Picker

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [blendModes count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[blendModes objectAtIndex:row] name];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	BlendMode * mode = [blendModes objectAtIndex:row];
	image.image = [UIImage imageByBlendingImage:topImage over:bottomImage withMode:mode.blendMode offset:CGPointMake(-2, -2)];
}

#pragma mark -

@end
