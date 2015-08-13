//
//  HotelTC.h
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel.h"

static NSString *const ALReusableHotelCellIdentifier = @"HotelCellIdentifier";

@interface HotelTC : UITableViewCell

- (void)layoutHotel:(Hotel *)hotel;

@end
