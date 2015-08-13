//
//  Hotel.m
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import "Hotel.h"

@implementation Hotel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"masterId" : @"master_id",
             @"name" : @"name",
             @"imageUrl" : @"thumbnail",
             @"address" : @"street_address",
             @"direction" : @"direction",
             @"distance" : @"distance",
             @"starRating" : @"star_rating",
             @"reviewScore" : @"review_score",
             @"nightlyRate" : @"nightly_rate",
             @"promotedNightlyRate" : @"promoted_nightly_rate",
             @"promotedTotalRate" : @"promoted_total_rate",
             @"totalRate" : @"total_rate",
             @"key" : @"key",
             @"latitude" : @"latitude",
             @"longitude" : @"longitude"
             };
}

@end
