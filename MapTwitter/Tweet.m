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
@synthesize coordinate;

- (Tweet *)initWithAll:(NSString *)Name Text:(NSString *)Text ImageURL:(NSString *)ImageURL Latitude:(double)Latitude Longitude:(double)Longitude {
    self = [super init];
    
    [self setName:Name];
    [self setText:Text];
    [self setImageURL:ImageURL];
    CLLocationCoordinate2D tweetCoordinate;
    tweetCoordinate.latitude = Latitude;
    tweetCoordinate.longitude = Longitude;
    [self setCoordinate:tweetCoordinate];
    
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
    CLLocationCoordinate2D tweetCoordinate;
    tweetCoordinate.latitude = [[array objectAtIndex:0] doubleValue];
    tweetCoordinate.longitude = [[array objectAtIndex:1] doubleValue];
    [self setCoordinate:tweetCoordinate];
    NSLog(@"%@", [self name]);
    return self;
}

@end
