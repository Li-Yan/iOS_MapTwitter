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

@interface TwitterDeveloper : NSObject

@property (nonatomic, strong) NSString *consumer_key;
@property (nonatomic, strong) NSString *consumer_secret;
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *access_token_secret;

- (TwitterDeveloper *) initAsDeveloper;
- (NSString *) tweetsSearch: (NSString *) URLString GeoLocation:(CLLocationCoordinate2D) geocode;

@end
