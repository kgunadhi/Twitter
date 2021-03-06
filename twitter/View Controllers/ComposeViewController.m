//
//  ComposeViewController.m
//  twitter
//
//  Created by Kaitlyn Gunadhi on 7/1/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.replyText) {
        self.tweetTextView.text = [self.replyText stringByAppendingString:@" "];
    }
    
    [self.tweetTextView becomeFirstResponder];
}

- (IBAction)closeCompose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)postTweet:(id)sender {
    if (self.replyId){
        [[APIManager shared] reply:self.tweetTextView.text replyId:self.replyId completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            }
            else{
                if (self.delegate) {
                    [self.delegate didTweet:tweet];
                }
            }
        }];
    } else {
        [[APIManager shared] postStatusWithText:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            }
            else{
                [self.delegate didTweet:tweet];
            }
        }];
    }
    [self dismissViewControllerAnimated:true completion:nil];
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
