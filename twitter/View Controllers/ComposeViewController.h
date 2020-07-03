//
//  ComposeViewController.h
//  twitter
//
//  Created by Kaitlyn Gunadhi on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (nonatomic, strong) NSString *replyId;
@property (nonatomic, strong) NSString *replyText;


@end

NS_ASSUME_NONNULL_END
