//
//  MapTwitterViewController.h
//  MapTwitter
//
//  Created by Li Yan on 3/6/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

#import "TwitterDeveloper.h"
#import "Tweet.h"

static CLLocationCoordinate2D myCoordinate;

static const double New_York_Latitude = 40.809520;
static const double New_York_Longitude = -73.959319;
static const double Meters_Per_Mile = 1609.344;

@interface MapTwitterViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *tweets;

- (void)initMapView;
- (void)fetchTweets;

@end
