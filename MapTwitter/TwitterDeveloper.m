//
//  TwitterDeveloper.m
//  MapTwitter
//
//  Created by Li Yan on 3/14/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import "TwitterDeveloper.h"

@implementation TwitterDeveloper

@synthesize consumer_key;
@synthesize consumer_secret;
@synthesize access_token;
@synthesize access_token_secret;

- (TwitterDeveloper *)initAsDeveloper {
    self = [super init];
    [self setConsumer_key:@"j1tFd2R0ww5S5ikVbaZNew"];
    [self setConsumer_secret:@"dDVPgML8W9aaSzX3UFSLeYNLwpiWbJQWpES62yz1kGA"];
    [self setAccess_token:@"736530565-wGvNFWsfY7e1AD2dKLWWqgwv1mEhmaJbawZQYrez"];
    [self setAccess_token_secret:@"icvZECvQ8w9UJrXWsFvVheeV8FcmfiiHnmyHGkNTxGI"];
    return self;
}

- (NSData *) tweetsSearch:(NSString *)URLString GeoLocation:(CLLocationCoordinate2D)geocode Range:(double)range {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    __block NSData *tweetsData = nil;
    [account requestAccessToAccountsWithType:accountType options:nil completion:[^(BOOL granted, NSError *error)
    {
        if (granted)
        {
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            ACAccount *twitter_account = [arrayOfAccounts objectAtIndex:0];
            ACAccountCredential *twitter_account_credential = [[ACAccountCredential alloc] initWithOAuthToken:self.access_token tokenSecret:self.access_token_secret];
            [twitter_account setCredential:twitter_account_credential];
            
            NSURL *requestURL = [NSURL URLWithString:URLString];
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
            NSString *geoString = [[NSString alloc] initWithFormat:@"%f,%f,%fmi", geocode.latitude, geocode.longitude, range];
            [parameters setObject:geoString forKey:@"geocode"];
            [parameters setObject:@"100" forKey:@"count"];
            [parameters setObject:@"apple" forKey:@"q"];
            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
            [request setAccount:twitter_account];
            [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                tweetsData = responseData;
            }];
        }
    }copy]];
    while (tweetsData == nil)
    {
       sleep(1);
    }
    return tweetsData;
}

- (NSData *) tweetsSearch: (NSString *)URLString GeoLocation:(CLLocationCoordinate2D)geocode {
    return [self tweetsSearch:URLString GeoLocation:geocode Range:1];
}

@end
