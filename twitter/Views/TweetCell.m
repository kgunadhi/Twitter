//
//  TweetCell.m
//  twitter
//
//  Created by Kaitlyn Gunadhi on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"

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
    
    self.profileView.image = nil;
    if (self.tweet.user.profileImage != nil) {
        [self.profileView setImageWithURL:self.tweet.user.profileImage];
    }
    self.profileView.layer.cornerRadius = 7;
}

- (IBAction)didTapFavorite:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    [self refreshData];
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    [self refreshData];
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
    }];
}

- (void)refreshData {
    self.retweetButton.selected = self.tweet.retweeted;
    self.retweetLabel.text = [@(self.tweet.retweetCount) stringValue];
    self.favoriteButton.selected = self.tweet.favorited;
    self.favoriteLabel.text = [@(self.tweet.favoriteCount) stringValue];
}

@end
