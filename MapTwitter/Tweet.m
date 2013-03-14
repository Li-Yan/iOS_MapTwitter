//
//  Tweet.m
//  MapTwitter
//
//  Created by Li Yan on 3/14/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize name;
@synthesize text;
@synthesize imageURL;
@synthesize latitude;
@synthesize longitude;

- (Tweet *)initWithAll:(NSString *)Name Text:(NSString *)Text ImageURL:(NSString *)ImageURL Latitude:(double)Latitude Longitude:(double)Longitude {
    self = [super init];
    
    [self setName:Name];
    [self setText:Text];
    [self setImageURL:ImageURL];
    [self setLatitude:Latitude];
    [self setLongitude:Longitude];
    
    return self;
}

- (Tweet *)initWithJSONDic:(NSDictionary *)tweetDic {
    self = [super init];
    
    NSDictionary *subDic = nil;
    subDic = [tweetDic objectForKey:@"user"];
    [self setName:[[NSString alloc] initWithFormat:@"%@", [subDic objectForKey:@"name"]]];
    [self setImageURL:[[NSString alloc] initWithFormat:@"%@", [subDic objectForKey:@"profile_image_url"]]];
    [self setText:[[NSString alloc] initWithFormat:@"%@", [tweetDic objectForKey:@"text"]]];
    subDic = [tweetDic objectForKey:@"geo"];
    NSArray *array = [subDic objectForKey:@"coordinates"];
    [self setLatitude:[[array objectAtIndex:0] doubleValue]];
    [self setLongitude:[[array objectAtIndex:1] doubleValue]];
    
    return self;
}

@end
