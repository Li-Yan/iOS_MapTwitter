//
//  MapTwitterViewController.m
//  MapTwitter
//
//  Created by Li Yan on 3/6/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import "MapTwitterViewController.h"

static NSMutableDictionary *tweets;

@interface MapTwitterViewController ()

@end

@implementation MapTwitterViewController

@synthesize myCoordinate;
@synthesize tagArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initMapView];
    
    tweets = [[NSMutableDictionary alloc] init];
    self.tagArray = [[NSMutableArray alloc] init];
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    [self fetchTweets];
    dispatch_async(dispatch_get_main_queue(), ^{[self PlaceTweetsPin];});
    
    NSThread *updateThread = [[NSThread alloc] initWithTarget:self selector:@selector(updateTweets) object:nil];
    [updateThread start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTweets:(Tweet *)tweet
{
    if ([tweets objectForKey:tweet.id_str] == nil)
    {
        [tweets setObject:tweet forKey:tweet.id_str];
        [self.tagArray addObject:tweet.id_str];
    }
}

+ (void)setRetweeted:(Tweet *)tweet
{
    tweet.retweeted = true;
    [tweets setObject:tweet forKey:tweet.id_str];
}

- (void)initMapView
{
    self.mapView.delegate = self;
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    CLLocationCoordinate2D coordinate2D = locationManager.location.coordinate;
    coordinate2D.latitude = New_York_Latitude;
    coordinate2D.longitude = New_York_Longitude;
    self.myCoordinate = coordinate2D;
    
    MKCoordinateSpan mySpan;
    mySpan.latitudeDelta = 0.027;
    mySpan.longitudeDelta = 0.027;
    
    MKCoordinateRegion myRegion;
    myRegion.center = coordinate2D;
    myRegion.span = mySpan;
    [self.mapView setRegion:myRegion animated:true];
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:coordinate2D radius:Search_Range * Meters_Per_Mile];
    [self.mapView addOverlay:circle];
    circle = [MKCircle circleWithCenterCoordinate:coordinate2D radius:17];
    [self.mapView addOverlay:circle];
}

- (void)PlaceTweetsPin
{
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:tweets];
    NSArray *keys = [dic allKeys];
    for (NSString *key in keys) {
        Tweet *tweet = [dic objectForKey:key];
        if (tweet.pined == false)
        {
            [self.mapView addAnnotation:tweet];
            tweet.pined = true;
            [tweets setObject:tweet forKey:tweet.id_str];
        }
    }
}

- (void)fetchTweets
{
    TwitterDeveloper *twitter_developer = [[TwitterDeveloper alloc] initAsDeveloper];
    NSString *tweetsSearchURL = @"https://api.twitter.com/1.1/search/tweets.json?";
    NSData *tweetsData = [twitter_developer tweetsSearch:tweetsSearchURL GeoLocation:self.myCoordinate Range:Search_Range];
    NSError *error = nil;
    NSDictionary *tweetsDic = [NSJSONSerialization JSONObjectWithData:tweetsData options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
    tweetsDic = [tweetsDic objectForKey:@"statuses"];
    for (NSDictionary *subDic in tweetsDic) {
        NSString *geoString = [[NSString alloc] initWithFormat:@"%@", [subDic objectForKey:@"geo"]];
        if (![geoString isEqualToString:@"<null>"])
            //Tweets that have "geo"
        {
            Tweet *tweet = [[Tweet alloc] initWithJSONDic:subDic];
            [self addTweets:tweet];
        }
    }
}

- (void)updateTweets
{
    while (true) {
        [self fetchTweets];
        dispatch_async(dispatch_get_main_queue(), ^{[self PlaceTweetsPin];});
        sleep(5);
    }
}

-(void) reloadMap
{
    [self.mapView setRegion:self.mapView.region animated:TRUE];
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
        if (((MKCircle *)overlay).radius <= 0.5 * Meters_Per_Mile) {
            cirView.alpha = 1;
        }
        cirView.lineWidth = 3.7;
        overlayView = cirView;
    }
    return overlayView;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"MapPin";
    if([annotation isKindOfClass:[Tweet class]])
    {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if(annotationView == nil)
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        else
        {
            [annotationView setAnnotation:annotation];
        }
        
        // Button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button setFrame:CGRectMake(0, 0, 23, 23)];
        [button setTag:[self.tagArray indexOfObject:((Tweet *)annotation).id_str]];
        [button addTarget:self action:@selector(tweetDetail:) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = button;
        
        // Image and two labels
        UIImageView *imageView = [[UIImageView alloc] initWithImage:((Tweet *)annotation).image];
        [imageView setFrame:CGRectMake(0,0,23,23)];
        annotationView.leftCalloutAccessoryView = imageView;
        
        [annotationView setPinColor:MKPinAnnotationColorGreen];
        [annotationView setEnabled:YES];
        [annotationView setCanShowCallout:YES];
        [annotationView setAnimatesDrop:YES];
        
        return annotationView;
    }
    return nil;
}

- (void)tweetDetail:(id)sender
{
    NSString *key = [self.tagArray objectAtIndex:((UIButton *)sender).tag];
    Tweet *tweet = [tweets objectForKey:key];
    MapTwitterDetailViewController *detailViewController = [[MapTwitterDetailViewController alloc] initWithTweet:tweet];
    [self presentViewController:detailViewController animated:YES completion:nil];
}

@end
