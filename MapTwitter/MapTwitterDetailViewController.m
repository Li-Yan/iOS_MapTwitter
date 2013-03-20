//
//  MapTwitterDetailViewController.m
//  MapTwitter
//
//  Created by Li Yan on 3/20/13.
//  Copyright (c) 2013 Li Yan. All rights reserved.
//

#import "MapTwitterDetailViewController.h"

@interface MapTwitterDetailViewController ()

@end

@implementation MapTwitterDetailViewController

@synthesize tweet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (MapTwitterDetailViewController *)initWithTweet:(Tweet *)init_tweet
{
    self = [super init];
    [self setTweet:init_tweet];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen alloc] applicationFrame]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    
    double titleLableWidth = screenSize.width / 2;
    double titleLableHeight = screenSize.height / 17;
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake((screenSize.width - titleLableWidth) / 2, 0, screenSize.width / 2, titleLableHeight)];
    [titleLable setText:@"Tweet Detail"];
    [titleLable setFont:[UIFont fontWithName:@"zapfino" size:(15.0f)]];
    [self.view addSubview:titleLable];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [returnButton setFrame:CGRectMake(0, 0, 37, 73)];
    [returnButton addTarget:self action:@selector(returnToMap:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:returnButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)returnToMap:(id)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end
