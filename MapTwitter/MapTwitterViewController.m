//
//  MapTwitterViewController.m
//  MapTwitter
//
//  Created by Li Yan on 3/6/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import "MapTwitterViewController.h"

@interface MapTwitterViewController ()

@end

@implementation MapTwitterViewController

@synthesize tweets;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initMapView];
    
    tweets = [[NSMutableArray alloc] init];
    [self fetchTweets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMapView
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D coordinate2D = locationManager.location.coordinate;
    coordinate2D.latitude = New_York_Latitude;
    coordinate2D.longitude = New_York_Longitude;
    myCoordinate = coordinate2D;
    
    MKCoordinateSpan mySpan;
    mySpan.latitudeDelta = 0.027;
    mySpan.longitudeDelta = 0.027;
    
    MKCoordinateRegion myRegion;
    myRegion.center = coordinate2D;
    myRegion.span = mySpan;
    [self.mapView setRegion:myRegion];
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate2D radius:Search_Range * Meters_Per_Mile];
    [self.mapView addOverlay:circle];
}

- (void)PlaceTweetsPin
{
    for (Tweet *tweet in tweets) {
        [self.mapView addAnnotation:tweet];
    }
}

- (void)fetchTweets
{
    TwitterDeveloper *twitter_developer = [[TwitterDeveloper alloc] initAsDeveloper];
    NSString *tweetsSearchURL = @"https://api.twitter.com/1.1/search/tweets.json?";
    NSData *tweetsData = [twitter_developer tweetsSearch:tweetsSearchURL GeoLocation:myCoordinate Range:Search_Range];
    NSError *error = nil;
    NSDictionary *tweetsDic = [NSJSONSerialization JSONObjectWithData:tweetsData options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
    tweetsDic = [tweetsDic objectForKey:@"statuses"];
    for (NSDictionary *subDic in tweetsDic) {
        NSString *geoString = [[NSString alloc] initWithFormat:@"%@", [subDic objectForKey:@"geo"]];
        if (![geoString isEqualToString:@"<null>"])
            //Tweets that have "geo"
        {
            Tweet *tweet = [[Tweet alloc] initWithJSONDic:subDic];
            [tweets addObject:tweet];
        }
    }
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKOverlayView *overlayView = nil;
    if ([overlay isKindOfClass:[MKCircle class]])
        //MKCircle
    {
        MKCircleView *cirView = [[MKCircleView alloc] initWithCircle:overlay];
        cirView.fillColor = [UIColor purpleColor];
        cirView.strokeColor = [UIColor purpleColor];
        cirView.alpha = 0.17;
        cirView.lineWidth = 3.7;
        overlayView = cirView;
    }
    return overlayView;
}

@end
