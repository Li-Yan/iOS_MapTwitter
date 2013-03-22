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

- (TwitterDeveloper *)initAsDeveloper
{
    self = [super init];
    [self setAccess_token:@"736530565-wGvNFWsfY7e1AD2dKLWWqgwv1mEhmaJbawZQYrez"];
    [self setAccess_token_secret:@"icvZECvQ8w9UJrXWsFvVheeV8FcmfiiHnmyHGkNTxGI"];
    return self;
}

- (NSData *)tweetsSearch:(NSString *)URLString GeoLocation:(CLLocationCoordinate2D)geocode Range:(double)range
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    __block NSData *tweetsData = nil;
    [account requestAccessToAccountsWithType:accountType options:nil completion:[^(BOOL granted, NSError *error)
    {
        if (granted)
        {
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            if (arrayOfAccounts.count > 0)
            {
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
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                 {
                     tweetsData = responseData;
                 }];
            }
            else
            {
                NSLog(@"No available account!");
            }
        }
        else
        {
            NSLog(@"Not granted!");
        }
    }copy]];
    while (tweetsData == nil)
    {
       sleep(1);
    }
    return tweetsData;
}

- (NSData *)tweetsSearch: (NSString *)URLString GeoLocation:(CLLocationCoordinate2D)geocode
{
    return [self tweetsSearch:URLString GeoLocation:geocode Range:1];
}

- (void)retweet:(NSString *)id_str
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
    {
        if (granted)
        {
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            ACAccount *twitter_account = [arrayOfAccounts objectAtIndex:0];
            ACAccountCredential *twitter_account_credential = [[ACAccountCredential alloc] initWithOAuthToken:self.access_token tokenSecret:self.access_token_secret];
            [twitter_account setCredential:twitter_account_credential];
            
            NSString *URLString = [[NSString alloc] initWithFormat:@"https://api.twitter.com/1.1/statuses/retweet/%@.json", id_str];
            NSURL *requestURL = [NSURL URLWithString:URLString];
            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:requestURL parameters:nil];
            [request setAccount:twitter_account];
            [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {}];
        }
        else
        {
            NSLog(@"Not granted!");
        }
    }];
}

- (void)favorite:(NSString *)id_str Is_Create:(BOOL)is_create
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
    {
        if (granted)
        {
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            if (arrayOfAccounts.count > 0)
            {
                ACAccount *twitter_account = [arrayOfAccounts objectAtIndex:0];
                ACAccountCredential *twitter_account_credential = [[ACAccountCredential alloc] initWithOAuthToken:self.access_token tokenSecret:self.access_token_secret];
                [twitter_account setCredential:twitter_account_credential];
                
                NSString *URLString = nil;
                if (is_create) URLString = [[NSString alloc] initWithFormat:@"https://api.twitter.com/1.1/favorites/create.json"];
                else URLString = [[NSString alloc] initWithFormat:@"https://api.twitter.com/1.1/favorites/destroy.json"];
                NSURL *requestURL = [NSURL URLWithString:URLString];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                [parameters setObject:id_str forKey:@"id"];
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:requestURL parameters:parameters];
                [request setAccount:twitter_account];
                [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {}];
            }
            else
            {
                NSLog(@"No available account!");
            }
        }
        else
        {
            NSLog(@"Not granted!");
        }
    }];
}

- (NSData *)getFavorite
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    __block NSData *favoriteData = nil;
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             if (arrayOfAccounts.count > 0)
             {
                 ACAccount *twitter_account = [arrayOfAccounts objectAtIndex:0];
                 ACAccountCredential *twitter_account_credential = [[ACAccountCredential alloc] initWithOAuthToken:self.access_token tokenSecret:self.access_token_secret];
                 [twitter_account setCredential:twitter_account_credential];
                 
                 NSString *URLString = nil;
                 URLString = [[NSString alloc] initWithFormat:@"https://api.twitter.com/1.1/favorites/list.json"];
                 NSURL *requestURL = [NSURL URLWithString:URLString];
                 NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                 SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
                 [request setAccount:twitter_account];
                 [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                 {
                     favoriteData = responseData;
                 }];
             }
             else
             {
                 NSLog(@"No available account!");
             }
         }
         else
         {
             NSLog(@"Not granted!");
         }
     }];
    while (favoriteData == nil)
    {
        sleep(1);
    }
    return favoriteData;
}

- (NSData *)timeLine
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    __block NSData *timelineData = nil;
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             if (arrayOfAccounts.count > 0)
             {
                 ACAccount *twitter_account = [arrayOfAccounts objectAtIndex:0];
                 ACAccountCredential *twitter_account_credential = [[ACAccountCredential alloc] initWithOAuthToken:self.access_token tokenSecret:self.access_token_secret];
                 [twitter_account setCredential:twitter_account_credential];
                 
                 NSString *URLString = nil;
                 URLString = [[NSString alloc] initWithFormat:@"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                 NSURL *requestURL = [NSURL URLWithString:URLString];
                 NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"200" forKey:@"count"];
                 SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:parameters];
                 [request setAccount:twitter_account];
                 [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      timelineData = responseData;
                  }];
             }
             else
             {
                 NSLog(@"No available account!");
             }
         }
         else
         {
             NSLog(@"Not granted!");
         }
     }];
    while (timelineData == nil)
    {
        sleep(1);
    }
    return timelineData;
}

@end
