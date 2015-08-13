//
//  Hotel.h
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "BaseModel.h"

@interface Hotel : BaseModel

@property (nonatomic, copy) NSNumber *masterId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *direction;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *starRating;
@property (nonatomic, copy) NSNumber *reviewScore;
@property (nonatomic, copy) NSString *nightlyRate;
@property (nonatomic, copy) NSString *promotedNightlyRate;
@property (nonatomic, copy) NSString *promotedTotalRate;
@property (nonatomic, copy) NSString *totalRate;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end
