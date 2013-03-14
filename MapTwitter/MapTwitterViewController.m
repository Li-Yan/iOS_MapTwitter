//
//  MapTwitterViewController.m
//  MapTwitter
//
//  Created by Li Yan on 3/6/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import "MapTwitterViewController.h"
#import "TwitterDeveloper.h"

@interface MapTwitterViewController ()

@end

@implementation MapTwitterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initMapView];
    
    TwitterDeveloper *twitter_developer = [[TwitterDeveloper alloc] initAsDeveloper];
    NSString *tweetsSearchURL = @"https://api.twitter.com/1.1/search/tweets.json?q=";
    tweetsSearchURL = [tweetsSearchURL stringByAppendingFormat:@"geocode=%f,%f,1mi", myCoordinate.latitude, myCoordinate.longitude];
    //NSString *responseString = [twitter_developer tweetsSearch:tweetsSearchURL];
    //NSLog(@"%@", responseString);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void) initMapView {
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
    mySpan.latitudeDelta = 0.006;
    mySpan.longitudeDelta = 0.006;
    
    MKCoordinateRegion myRegion;
    myRegion.center = coordinate2D;
    myRegion.span = mySpan;
    [self.mapView setRegion:myRegion];
}

@end
