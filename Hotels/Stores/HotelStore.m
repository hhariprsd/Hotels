//
//  HotelStore.m
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import "HotelStore.h"
#import "Hotel.h"

@implementation HotelStore

+ (instancetype)sharedStore
{
    static HotelStore *sharedHotelStore = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHotelStore = [[HotelStore alloc] init];
    });
    
    return sharedHotelStore;
}

- (void)getHotels:( void (^)(NSArray *hotels) )success
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hotels" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *hotelsArray = [Hotel arrayFromJSONArray:json[@"hotels"]];
    success(hotelsArray);
}
@end
