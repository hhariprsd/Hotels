//
//  BaseModel.m
//  Hotels
//
//  Created by Hari Prasad on 8/12/15.
//  Copyright (c) 2015 HARI PRASAD. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

+ (instancetype)modelFromJSONDictionary:(NSDictionary *)JSONDictionary
{
    NSError *error = nil;
    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:JSONDictionary error:&error];
}

+ (NSArray *)arrayFromJSONArray:(NSArray *)array
{
    NSValueTransformer *valueTransformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[self class]];
    NSMutableArray *objects = [valueTransformer transformedValue:array];
    
    return objects;
}
@end
