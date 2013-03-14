//
//  MapTwitterAppDelegate.h
//  MapTwitter
//
//  Created by Li Yan on 3/6/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

static CLLocationCoordinate2D myCoordinate;

@interface MapTwitterAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *twitter_account_option;

+ (void) Set_My_Coordinate: (CLLocationCoordinate2D) My_Coordinate;
+ (CLLocationCoordinate2D) Get_My_Coordinate;

@end
