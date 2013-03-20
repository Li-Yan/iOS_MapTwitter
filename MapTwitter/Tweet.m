//
//  Tweet.m
//  MapTwitter
//
//  Created by Li Yan on 3/14/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize id_str;
@synthesize name;
@synthesize text;
@synthesize imageURL;
@synthesize image;
@synthesize title;
@synthesize coordinate;
@synthesize pined;

- (Tweet *)initWithJSONDic:(NSDictionary *)tweetDic {
    self = [super init];
    
    NSDictionary *subDic = nil;
    [self setId_str:[[NSString alloc] initWithFormat:@"%@", [tweetDic objectForKey:@"id_str"]]];
    subDic = [tweetDic objectForKey:@"user"];
    [self setName:[[NSString alloc] initWithFormat:@"%@", [subDic objectForKey:@"name"]]];
    [self setImageURL:[[NSString alloc] initWithFormat:@"%@", [subDic objectForKey:@"profile_image_url"]]];
    [self setText:[[NSString alloc] initWithFormat:@"%@", [tweetDic objectForKey:@"text"]]];
    NSURL* url = [NSURL URLWithString:self.imageURL];
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:url];
    [self setImage:[[UIImage alloc] initWithData:imageData]];
    
    [self setTitle:[[NSString alloc] initWithFormat:@"%@", self.name]];
    subDic = [tweetDic objectForKey:@"geo"];
    NSArray *array = [subDic objectForKey:@"coordinates"];
    CLLocationCoordinate2D tweetCoordinate;
    tweetCoordinate.latitude = [[array objectAtIndex:0] doubleValue];
    tweetCoordinate.longitude = [[array objectAtIndex:1] doubleValue];
    [self setCoordinate:tweetCoordinate];
    [self setPined:false];
    
    return self;
}

@end
