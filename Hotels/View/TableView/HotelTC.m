//
//  HotelTC.m
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import "HotelTC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "EDStarRating.h"

@interface HotelTC()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet EDStarRating *ratingView;

@end

@implementation HotelTC

- (void)layoutHotel:(Hotel *)hotel
{
    self.name.text = hotel.name;
    [self.image sd_setImageWithURL:[NSURL URLWithString:hotel.imageUrl]];
    self.image.clipsToBounds = YES;
    self.distance.text = [NSString stringWithFormat:@"%@ mi",hotel.distance];
    [self layoutRating:hotel.starRating];
}

-(void)layoutRating:(NSString *)rating
{
    self.ratingView.starImage = [UIImage imageNamed:@"star_unselected.png"];
    self.ratingView.starHighlightedImage = [UIImage imageNamed:@"star_selected.png"];
    self.ratingView.maxRating = 5.0;
    self.ratingView.horizontalMargin = 5;
    self.ratingView.editable=NO;
    self.ratingView.displayMode=EDStarRatingDisplayAccurate;
    int ratingValue = [rating intValue];
    if(ratingValue <= 0){
        self.ratingView.rating = 0;
    }
    else if(ratingValue >= 5){
        self.ratingView.rating = 5;
    }
    else{
        self.ratingView.rating = ratingValue;
    }
    
}
@end
