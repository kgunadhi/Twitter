//
//  DetailsViewController.m
//  twitter
//
//  Created by Kaitlyn Gunadhi on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "APIManager.h"
#import "WebViewController.h"
#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ResponsiveLabel.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet ResponsiveLabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (nonatomic, strong) NSURL *tappedUrl;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    self.tweetTextLabel.text = self.tweet.text;
    self.retweetButton.selected = self.tweet.retweeted;
    self.retweetLabel.text = [@(self.tweet.retweetCount) stringValue];
    self.favoriteButton.selected = self.tweet.favorited;
    self.favoriteLabel.text = [@(self.tweet.favoriteCount) stringValue];
    
    [self.nameLabel sizeToFit];
    [self.screenNameLabel sizeToFit];
    [self.dateLabel sizeToFit];
    [self.retweetLabel sizeToFit];
    [self.favoriteLabel sizeToFit];
    
    // HashTag detection
    PatternTapResponder hashTagTapAction = ^(NSString *tappedString) {};
    [self.tweetTextLabel enableHashTagDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor systemBlueColor], RLTapResponderAttributeName:hashTagTapAction}];
    
    // Username handle detection
    PatternTapResponder userHandleTapAction = ^(NSString *tappedString){};
    [self.tweetTextLabel enableUserHandleDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor systemBlueColor],RLTapResponderAttributeName:userHandleTapAction}];
    
    // URL detection
    PatternTapResponder urlTapAction = ^(NSString *tappedString) {
        self.tappedUrl = [NSURL URLWithString:tappedString];
        [self performSegueWithIdentifier:@"WebSegue" sender:nil];
    };
    [self.tweetTextLabel enableURLDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor systemBlueColor],NSUnderlineStyleAttributeName:[NSNumber
    numberWithInt:1],RLTapResponderAttributeName:urlTapAction}];
    
    self.profileView.image = nil;
    if (self.tweet.user.profileImage != nil) {
        [self.profileView setImageWithURL:self.tweet.user.profileImage];
    }
    self.profileView.layer.cornerRadius = self.profileView.frame.size.width / 2;
    self.profileView.clipsToBounds = YES;
}

- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = !self.tweet.favorited;
    if (self.tweet.favorited == YES) {
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {}];
    } else {
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {}];
    }
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = !self.tweet.retweeted;
    if (self.tweet.retweeted == YES) {
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {}];
    } else {
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {}];
    }
    [self refreshData];
}

- (void)refreshData {
    self.retweetButton.selected = self.tweet.retweeted;
    self.retweetLabel.text = [@(self.tweet.retweetCount) stringValue];
    self.favoriteButton.selected = self.tweet.favorited;
    self.favoriteLabel.text = [@(self.tweet.favoriteCount) stringValue];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"WebSegue"]) {
        WebViewController *webViewController = [segue destinationViewController];
        webViewController.tappedUrl = self.tappedUrl;
    } else {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.replyText = [@"@" stringByAppendingString:self.tweet.user.screenName];
        composeController.replyId = self.tweet.idStr;
    }
}

@end
