//
//  Tweet.h
//  MapTwitter
//
//  Created by Li Yan on 3/14/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Tweet : NSObject <MKAnnotation>

//Tweets
@property (nonatomic, strong) NSString *id_str;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImage *image;

//Map
@property (nonatomic, strong) NSString *title;
@property CLLocationCoordinate2D coordinate;
@property BOOL pined;

- (Tweet *) initWithJSONDic:(NSDictionary *)tweetDic;

@end
