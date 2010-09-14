//
//  ImageResizingViewController.h
//  ImageResizing
//
//  Created by Cory Kilger on 9/13/10.
//  Copyright 2010 Cory Kilger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageResizingViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
	NSArray * scaleModes;
	
	UIImage * image;
	UIImageView * imageView1;
	UIImageView * imageView2;
	UIPickerView * picker;
}

@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) IBOutlet UIImageView * imageView1;
@property (nonatomic, retain) IBOutlet UIImageView * imageView2;
@property (nonatomic, retain) IBOutlet UIPickerView * picker;

@end

