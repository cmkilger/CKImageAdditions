/*  Created by Cory Kilger on 2/1/11.
 *
 *	Copyright (c) 2010 Cory Kilger.
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy
 *	of this software and associated documentation files (the "Software"), to deal
 *	in the Software without restriction, including without limitation the rights
 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *	copies of the Software, and to permit persons to whom the Software is
 *	furnished to do so, subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in
 *	all copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *	THE SOFTWARE.
 */

#import "UIImage+ImageColoring.h"
#import "CoreGraphicsAdditions.h"

static inline unsigned long RGBToUInt32(int r, int g, int b, int a) {
	return (a << 24) | (b << 16) | (g << 8) | r;
}

static inline void UInt32ToRGB(unsigned long color, int * r, int * g, int * b, int * a) {
	*r = color%256;
	color = color >> 8;
	*g = color%256;
	color = color >> 8;
	*b = color%256;
	color = color >> 8;
	*a = color%256;
}

static inline void RGBToHSL(CGFloat r, CGFloat g, CGFloat b, CGFloat * h, CGFloat * s, CGFloat * l) {
	float mincolor = fminf(fminf(r, g), b);
	float maxcolor = fmaxf(fmaxf(r, g), b);
	
	*h = 0;
	*s = 0;
	*l = (maxcolor + mincolor)/2;
	
	if (maxcolor == mincolor)
		return;
	
	if (*l < 0.5)
		*s = (maxcolor - mincolor)/(maxcolor + mincolor);
	else
		*s = (maxcolor - mincolor)/(2.0 - maxcolor - mincolor);
	
	if (r == maxcolor)
		*h = (g - b)/(maxcolor - mincolor);
	else if (g == maxcolor)
		*h = 2.0 + (b - r)/(maxcolor - mincolor);
	else
		*h = 4.0 + (r - g)/(maxcolor - mincolor);
	
	*h /= 6;
}

static inline void HSLToRGB(CGFloat h, CGFloat s, CGFloat l, CGFloat * r, CGFloat * g, CGFloat * b) {
	if (s == 0) {
		*r = *g = *b = l;
		return;
	}
	
	float temp2 = 0;
	
	if (l < 0.5)
		temp2 = l*(1 + s);
	else
		temp2 = l+s-l*s;
	
	float temp1 = 2*l - temp2;
	
	float temp[3];
	temp[0] = h + 1/3.0;
	temp[1] = h;
	temp[2] = h - 1/3.0;
	
	for (int i = 0; i < 3; i++) {
		float temp3 = temp[i];
		if (temp3 < 0)
			temp3 += 1.0;
		else if (temp3 > 1)
			temp3 -= 1.0;
		
		float color = 0;
		if (6*temp3 < 1)
			color = temp1+(temp2-temp1)*6*temp3;
		else if (2*temp3 < 1)
			color = temp2;
		else if (3*temp3 < 2)
			color = temp1+(temp2 - temp1)*(4 - temp3*6);
		else
			color = temp1;
		
		switch (i) {
			case 0:
				*r = color;
				break;
			case 1:
				*g = color;
				break;
			case 2:
				*b = color;
				break;
		}
	}
}

@implementation UIImage (ImageColoring)

- (UIImage *) imageByAdjustingHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness {
	
	hue /= 360.0;
	saturation /= 100.0;
	lightness /= 100.0;
	
	if (hue < 0)
		hue += 1.0;
	
	CGContextRef context = CKBitmapContextCreateWithImage([self CGImage]);
	
	UInt32 * data = CGBitmapContextGetData(context);
	size_t width = CGBitmapContextGetWidth(context);
	size_t height = CGBitmapContextGetHeight(context);
	
	for (size_t x = 0; x < width; x++) {
		for (size_t y = 0; y < height; y++) {
			NSUInteger index = y*width+x;
			UInt32 color = data[index];
			int rInt, gInt, bInt, aInt;
			UInt32ToRGB(color, &rInt, &gInt, &bInt, &aInt);
			CGFloat h, s, l;
			CGFloat r = rInt/255.0, g = gInt/255.0, b = bInt/255.0;
			RGBToHSL(r, g, b, &h, &s, &l);
			
			h = h+hue;
			if (h > 1.0)
				h -= 1.0;
			
			if (saturation < 0)
				s = s*(1.0+saturation);
			else if (saturation > 0)
				s = (1.0-s)*saturation+s;
			
			if (lightness < 0)
				l = l*(1.0+lightness);
			else if (lightness > 0)
				l = (1.0-l)*lightness+l;
			
			HSLToRGB(h, s, l, &r, &g, &b);
			color = RGBToUInt32(r*255, g*255, b*255, aInt);
			data[index] = color;
		}
	}
	
	CGImageRef newImage = CGBitmapContextCreateImage(context);
	UIImage * image = [UIImage imageWithCGImage:newImage];
	
	CGImageRelease(newImage);
	CGContextRelease(context);
	
	return image;
}

@end
