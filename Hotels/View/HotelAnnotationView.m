//
//  HotelAnnotationView.m
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import "HotelAnnotationView.h"

@implementation HotelAnnotationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.size = CGSizeMake(64.0f, 64.0f);
        self.frame = frame;
        [self setOpaque:NO];
        self.canShowCallout = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *backgroundImage = [UIImage imageNamed:@"pin"];
    UIBezierPath *rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 64.0f, 64.0f)];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawTiledImage(context, CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height), backgroundImage.CGImage);
    CGContextRestoreGState(context);
}

@end
