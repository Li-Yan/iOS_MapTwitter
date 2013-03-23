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
@synthesize developer;
@synthesize sideBlank;
@synthesize up_downBlank;
@synthesize horizontalBlank;
@synthesize verticalBlank;
@synthesize screenSize;
@synthesize buttonSize;
@synthesize currentHeight;

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
    [self setDeveloper:[[TwitterDeveloper alloc] initAsDeveloper]];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen alloc] applicationFrame]];
    [self.view setBackgroundColor:[UIColor colorWithRed:191/255.0f green:237/255.0f blue:255/255.0f alpha:1]];
    
    sideBlank = 17;
    up_downBlank = 3;
    horizontalBlank = 3;
    verticalBlank = 3;
    currentHeight = up_downBlank;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    
    //"Tweet Detail label"
    double titleLabelWidth = screenSize.width - 2 * sideBlank;
    double titleLabelHeight = screenSize.height / 15;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenSize.width - titleLabelWidth) / 2, currentHeight, titleLabelWidth, titleLabelHeight)];
    [titleLabel setText:@"Tweet Detail"];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:27.0f]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor colorWithRed:46/255.0f green:193/255.0f blue:255/255.0f alpha:1]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    currentHeight = currentHeight + titleLabelHeight + 3 * verticalBlank;
    
    //image
    double imageWidth = 73;
    double imageHeight = 73;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.tweet.image];
    [imageView setFrame:CGRectMake(sideBlank, currentHeight + verticalBlank, imageWidth, imageHeight)];
    
    //name Label
    double nameLabelWidth = screenSize.width - 2 * sideBlank - imageWidth - horizontalBlank;
    double nameLabelHeight = screenSize.height / 25;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(sideBlank + imageWidth + horizontalBlank, currentHeight + verticalBlank, nameLabelWidth, nameLabelHeight)];
    [nameLabel setText:tweet.name];
    [nameLabel setFont:[UIFont fontWithName:@"Arial Black" size:(13.0f)]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setTextColor:[UIColor blackColor]];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    currentHeight = currentHeight + verticalBlank + nameLabelHeight;
    
    //tweet text
    double textViewWidth = nameLabelWidth;
    double textViewHeight = screenSize.height / 5;
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(sideBlank + imageWidth + horizontalBlank, currentHeight + 1, textViewWidth, textViewHeight)];
    [self.textView setText:tweet.text];
    [self.textView setTextAlignment:NSTextAlignmentLeft];
    [self.textView setTextColor:[UIColor blackColor]];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setScrollEnabled:YES];
    currentHeight = currentHeight + 1 + textViewHeight;
    
    double timeLabelWidth = screenSize.width - 2 * sideBlank - horizontalBlank;
    double timeLabelHeight = screenSize.height / 25;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(sideBlank, currentHeight + 2 *  verticalBlank, timeLabelWidth, timeLabelHeight)];
    [timeLabel setText:tweet.timeStamp];
    [timeLabel setFont:[UIFont fontWithName:@"Arial" size:(13.0f)]];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeLabel setTextColor:[UIColor blackColor]];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    currentHeight = currentHeight + verticalBlank + timeLabelHeight;
    
    //move image
    [imageView setFrame:CGRectMake(sideBlank, up_downBlank + titleLabelHeight +verticalBlank + ((currentHeight - up_downBlank - titleLabelHeight - verticalBlank - imageHeight) / 2), imageWidth, imageHeight)];
    
    //text field
    /*
    double textFieldWidth = screenSize.width - 2 * sideBlank;
    double textFieldHeight = screenSize.height / 2.3;
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(sideBlank, currentHeight + verticalBlank, textFieldWidth, textFieldHeight)];
    [self.textField setText:@"Please input your reply here"];
    [self.textField setFont:[UIFont fontWithName:@"Noteworthy" size:(17.0f)]];
    [self.textField setTextAlignment:NSTextAlignmentLeft];
    [self.textField setTextColor:[UIColor colorWithRed:46/255.0f green:193/255.0f blue:255/255.0f alpha:1]];
    [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
    self.textField.delegate = self;
    currentHeight = currentHeight + verticalBlank + textFieldHeight;
    */
    
    //buttons
    self.buttonSize = 27;
    double buttonWidth = self.buttonSize;
    double buttonHeight = self.buttonSize;
    double buttonScale = 1;
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(3 * sideBlank, currentHeight + (screenSize.height - currentHeight - buttonHeight - verticalBlank) / 2 - 2 * up_downBlank, buttonWidth, buttonHeight)];
    [backButton addTarget:self action:@selector(returnToMap:) forControlEvents:UIControlEventTouchUpInside];
    
    self.retweetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (!tweet.retweeted) [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
    else [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweeted.png"] forState:UIControlStateNormal];
    [self.retweetButton setFrame:CGRectMake(screenSize.width - 3 * sideBlank - buttonWidth, currentHeight + (screenSize.height - currentHeight - buttonHeight - verticalBlank) / 2 - 2 * up_downBlank, buttonWidth, buttonHeight)];
    [self.retweetButton addTarget:self action:@selector(retweet:) forControlEvents:UIControlEventTouchUpInside];
    
    //favorite button
    self.favoriteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    if (!tweet.favorited)
    {
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
        buttonScale = 1;
    }
    else
    {
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorited.png"] forState:UIControlStateNormal];
        buttonScale = 3;
    }
    [self.favoriteButton setFrame:CGRectMake((screenSize.width - buttonScale * buttonWidth) / 2, currentHeight + (screenSize.height - currentHeight - buttonScale * buttonHeight - verticalBlank) / 2 - 2 * up_downBlank, buttonScale * buttonWidth, buttonScale * buttonHeight)];
    [self.favoriteButton addTarget:self action:@selector(favorite:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:imageView];
    [self.view addSubview:nameLabel];
    [self.view addSubview:self.textView];
    [self.view addSubview:timeLabel];
    [self.view addSubview:backButton];
    [self.view addSubview:self.retweetButton];
    [self.view addSubview:self.favoriteButton];
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

- (void)retweet:(id)sender
{
    NSString *messageString = [[NSString alloc] init];
    if (!tweet.retweeted)
    {
        tweet.retweeted = true;
        [developer retweet:tweet.id_str];
        messageString = @"Retweet Succeeds!";
        [MapTwitterViewController setRetweetState:tweet State:true];
        [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweeted.png"] forState:UIControlStateNormal];
    }
    else
    {
        messageString = @"Already Retweeted!";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Retweet Message" message:messageString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
}

- (void)favorite:(id)sender
{
    NSString *messageString = [[NSString alloc] init];
    double buttonWidth = self.buttonSize;
    double buttonHeight = self.buttonSize;
    double buttonScale = 1;
    if (!tweet.favorited)
    {
        buttonScale = 3;
        [developer favorite:tweet.id_str Is_Create:true];
        tweet.favorited = true;
        messageString = @"Add to Favority!";
        [MapTwitterViewController setFavoriteState:tweet State:true];
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorited.png"] forState:UIControlStateNormal];
    }
    else
    {
        buttonScale = 1;
        [developer favorite:tweet.id_str Is_Create:false];
        tweet.favorited = false;
        messageString = @"Remove from Favority!";
        [MapTwitterViewController setFavoriteState:tweet State:false];
        [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    }
    [self.favoriteButton setFrame:CGRectMake((screenSize.width - buttonScale * buttonWidth) / 2, currentHeight + (screenSize.height - currentHeight - buttonScale * buttonHeight - verticalBlank) / 2 - 2 * up_downBlank, buttonScale * buttonWidth, buttonScale * buttonHeight)];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Favorite Message" message:messageString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alertView show];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view)
    {
        [self.textField resignFirstResponder];
        [self.textView resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField selectAll:self];
}

@end
