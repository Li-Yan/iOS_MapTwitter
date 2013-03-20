//
//  TwitterDeveloper.h
//  MapTwitter
//
//  Created by Li Yan on 3/14/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <CoreLocation/CoreLocation.h>
#import <unistd.h>

//#import "MapTwitterViewController.h"

@interface TwitterDeveloper : NSObject

@property (nonatomic, strong) NSString *consumer_key;
@property (nonatomic, strong) NSString *consumer_secret;
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *access_token_secret;

- (TwitterDeveloper *) initAsDeveloper;
- (NSData *) tweetsSearch:(NSString *)URLString GeoLocation:(CLLocationCoordinate2D)geocode;
- (NSData *) tweetsSearch:(NSString *)URLString GeoLocation:(CLLocationCoordinate2D)geocode Range:(double) range;

- (void)retweet:(NSString *)id_str;
- (void)favoriteCreate:(NSString *)id_str;

@end
