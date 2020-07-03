//
//  TweetCell.m
//  twitter
//
//  Created by Kaitlyn Gunadhi on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "WebViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ResponsiveLabel.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.dateLabel.text = [@"· " stringByAppendingString:self.tweet.relativeTimeString];
    self.tweetTextLabel.text = self.tweet.text;
    self.retweetButton.selected = self.tweet.retweeted;
    self.retweetLabel.text = [@(self.tweet.retweetCount) stringValue];
    self.favoriteButton.selected = self.tweet.favorited;
    self.favoriteLabel.text = [@(self.tweet.favoriteCount) stringValue];
    
    // HashTag detection
    PatternTapResponder hashTagTapAction = ^(NSString *tappedString) {};
    [self.tweetTextLabel enableHashTagDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor systemBlueColor], RLTapResponderAttributeName:hashTagTapAction}];
    
    // Username handle detection
    PatternTapResponder userHandleTapAction = ^(NSString *tappedString){};
    [self.tweetTextLabel enableUserHandleDetectionWithAttributes:
    @{NSForegroundColorAttributeName:[UIColor systemBlueColor],RLTapResponderAttributeName:userHandleTapAction}];
    
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
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = !self.tweet.retweeted;
    if (self.tweet.retweeted == YES) {
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

- (void)refreshData {
    self.retweetButton.selected = self.tweet.retweeted;
    self.retweetLabel.text = [@(self.tweet.retweetCount) stringValue];
    self.favoriteButton.selected = self.tweet.favorited;
    self.favoriteLabel.text = [@(self.tweet.favoriteCount) stringValue];
}

@end
