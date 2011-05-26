//
//  ImageColoringCircleOverlay.m
//  ImageColoring
//
//  Created by Cory Kilger on 5/25/11.
//  Copyright 2011 Cory Kilger. All rights reserved.
//

#import "ImageColoringCircleOverlay.h"
#import "ImageColoringViewController.h"


@implementation ImageColoringCircleOverlay

@synthesize center, radius, viewController;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	self.center = [[touches anyObject] locationInView:self];
	[viewController sliderChanged];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	self.center = [[touches anyObject] locationInView:self];
	[viewController sliderChanged];
}

#pragma mark -

- (void)setCenter:(CGPoint)newCenter {
	center = newCenter;
	[self setNeedsDisplay];
}

- (void)setRadius:(CGFloat)newRadius {
	radius = newRadius;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextAddArc(context, center.x, center.y, radius/1.25, -M_PI, M_PI, 0);
	CGContextStrokePath(context);
	CGContextMoveToPoint(context, center.x-10, center.y);
	CGContextAddLineToPoint(context, center.x+10, center.y);
	CGContextStrokePath(context);
	CGContextMoveToPoint(context, center.x, center.y-10);
	CGContextAddLineToPoint(context, center.x, center.y+10);
	CGContextStrokePath(context);
}

@end
