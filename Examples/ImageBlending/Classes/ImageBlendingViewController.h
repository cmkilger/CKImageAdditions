//
//  ImageBlendingViewController.h
//  ImageBlending
//
//  Created by Cory Kilger on 9/9/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBlendingViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	NSArray * blendModes;
	
	UIImage * bottomImage;
	UIImage * topImage;
	
	UIImageView * image;
	UIPickerView * picker;
}

@property (nonatomic, retain) IBOutlet UIImageView * image;
@property (nonatomic, retain) IBOutlet UIPickerView * picker;

@end

