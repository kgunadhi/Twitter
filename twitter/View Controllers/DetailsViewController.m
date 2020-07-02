//
//  DetailsViewController.m
//  twitter
//
//  Created by Kaitlyn Gunadhi on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

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
    
    self.profileView.image = nil;
    if (self.tweet.user.profileImage != nil) {
        [self.profileView setImageWithURL:self.tweet.user.profileImage];
    }
    self.profileView.layer.cornerRadius = 7;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
