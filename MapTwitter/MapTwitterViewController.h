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
#import "MapTwitterDetailViewController.h"

static const double New_York_Latitude = 40.809520;
static const double New_York_Longitude = -73.959319;
static const double Meters_Per_Mile = 1609.344;
static const double Search_Range = 1;                   //1 mile search range for tweets.

@interface MapTwitterViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property CLLocationCoordinate2D myCoordinate;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

//for button tag
@property NSMutableArray *tagArray;

- (void)addTweets:(Tweet *) tweet;
+ (void)setRetweeted:(Tweet *) tweet;

- (void)initMapView;
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay;
- (void)fetchTweets;
- (void)updateTweets;


@end
