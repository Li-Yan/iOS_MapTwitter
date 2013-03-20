//
//  MapTwitterDetailViewController.h
//  MapTwitter
//
//  Created by Li Yan on 3/20/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Tweet.h"
#import "TwitterDeveloper.h"
#import "MapTwitterViewController.h"

@interface MapTwitterDetailViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, strong) TwitterDeveloper *developer;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;

- (MapTwitterDetailViewController *)initWithTweet:(Tweet *)init_tweet;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end
