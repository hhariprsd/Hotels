//
//  BaseModel.h
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseModel : MTLModel <MTLJSONSerializing>

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)JSONDictionary;
+ (NSArray *)arrayFromJSONArray:(NSArray *)array;
@end
