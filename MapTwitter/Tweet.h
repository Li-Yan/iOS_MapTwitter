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

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imageURL;
@property CLLocationCoordinate2D coordinate;

- (Tweet *) initWithAll:(NSString *)Name Text:(NSString *)Text ImageURL:(NSString *)ImageURL Latitude:(double)Latitude Longitude:(double)Longitude;
- (Tweet *) initWithJSONDic:(NSDictionary *)tweetDic;

@end
