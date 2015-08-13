//
//  HotelStore.h
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelStore : NSObject

+ (instancetype)sharedStore;
- (void)getHotels:( void (^)(NSArray *hotels) )success;

@end
