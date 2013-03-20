//
//  MapTwitterDetailViewController.h
//  MapTwitter
//
//  Created by Li Yan on 3/20/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tweet.h"

@interface MapTwitterDetailViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UITextField *textField;

- (MapTwitterDetailViewController *)initWithTweet:(Tweet *)init_tweet;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
