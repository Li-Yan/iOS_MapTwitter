//
//  TwitterDeveloper.m
//  MapTwitter
//
//  Created by Li Yan on 3/14/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <unistd.h>

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

- (NSString *) tweetsSearch:(NSString *)URLString {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    __block NSString *responseString = nil;
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
            [parameters setObject:@"200" forKey:@"count"];
            [parameters setObject:@"1" forKey:@"include_entities"];
            SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:nil];
            [request setAccount:twitter_account];
            [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            }];
        }
    }copy]];
    sleep(1);
    return responseString;
}

@end
