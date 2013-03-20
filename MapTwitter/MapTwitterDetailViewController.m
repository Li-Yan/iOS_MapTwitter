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
    
    double sideBlank = 10;
    double up_downBlank = 3;
    double horizontalBlank = 3;
    double verticalBlank = 3;
    double currentHeight = up_downBlank;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    
    //"Tweet Detail label"
    double titleLabelWidth = screenSize.width - 2 * sideBlank;
    double titleLabelHeight = screenSize.height / 15;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenSize.width - titleLabelWidth) / 2, currentHeight, titleLabelWidth, titleLabelHeight)];
    [titleLabel setText:@"Tweet Detail"];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:27.0f]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor colorWithRed:46/255.0f green:193/255.0f blue:255/255.0f alpha:1]];
    currentHeight = currentHeight + titleLabelHeight + 3 * verticalBlank;
    [self.view addSubview:titleLabel];
    
    //image
    double imageWidth = 73;
    double imageHeight = 73;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.tweet.image];
    [imageView setFrame:CGRectMake(sideBlank, currentHeight + verticalBlank, imageWidth, imageHeight)];
    [self.view addSubview:imageView];
    
    //name Label
    double nameLabelWidth = screenSize.width - 2 * sideBlank - imageWidth - horizontalBlank;
    double nameLabelHeight = screenSize.height / 25;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(sideBlank + imageWidth + horizontalBlank, currentHeight + verticalBlank, nameLabelWidth, nameLabelHeight)];
    [nameLabel setText:tweet.name];
    [nameLabel setFont:[UIFont fontWithName:@"Arial Black" size:(13.0f)]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setTextColor:[UIColor blackColor]];
    currentHeight = currentHeight + verticalBlank + nameLabelHeight;
    [self.view addSubview:nameLabel];
    
    //tweet text
    double textViewWidth = nameLabelWidth;
    double textViewHeight = screenSize.height / 5;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(sideBlank + imageWidth + horizontalBlank, currentHeight + 1, textViewWidth, textViewHeight)];
    [textView setText:tweet.text];
    [textView setTextAlignment:NSTextAlignmentLeft];
    [textView setTextColor:[UIColor blackColor]];
    [textView setScrollEnabled:YES];
    currentHeight = currentHeight + 1 + textViewHeight;
    [self.view addSubview:textView];
    
    //move image
    [imageView setFrame:CGRectMake(sideBlank, up_downBlank + titleLabelHeight +verticalBlank + ((currentHeight - up_downBlank - titleLabelHeight - verticalBlank - imageHeight) / 2), imageWidth, imageHeight)];
    
    //text field
    double textFieldWidth = screenSize.width - 2 * sideBlank;
    double textFieldHeight = screenSize.height / 2.3;
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(sideBlank, currentHeight + verticalBlank, textFieldWidth, textFieldHeight)];
    [self.textField setText:@"Please input here"];
    [self.textField setFont:[UIFont fontWithName:@"Noteworthy" size:(13.0f)]];
    [self.textField setTextAlignment:NSTextAlignmentLeft];
    [self.textField setTextColor:[UIColor blackColor]];
    [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
    currentHeight = currentHeight + verticalBlank + textFieldHeight;
    [self.view addSubview:self.textField];
    
    //buttons
    double buttonWidth = screenSize.width / 5;
    double buttonHeight = 37;
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [returnButton setFrame:CGRectMake(3 * sideBlank, currentHeight + (screenSize.height - currentHeight - buttonHeight - verticalBlank) / 2 - up_downBlank, buttonWidth, buttonHeight)];
    [returnButton setTitle:@"Return" forState:UIControlStateNormal];
    [returnButton setBackgroundColor:[UIColor redColor]];
    [returnButton addTarget:self action:@selector(returnToMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnButton];
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [postButton setFrame:CGRectMake(screenSize.width - 3 * sideBlank - buttonWidth, currentHeight + (screenSize.height - currentHeight - buttonHeight - verticalBlank) / 2 - up_downBlank, buttonWidth, buttonHeight)];
    [postButton setTitle:@"Reply" forState:UIControlStateNormal];
    [postButton setBackgroundColor:[UIColor blueColor]];
    [postButton addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postButton];
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

- (void)post:(id)sender
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = (UIView *)[touch view];
    if (view == self.view)
    {
        [self.textField resignFirstResponder];
    }
}

@end
