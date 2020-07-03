//
//  WebViewController.m
//  twitter
//
//  Created by Kaitlyn Gunadhi on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "WebViewController.h"
#import "WebKit/WebKit.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.tappedUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [self.webView loadRequest:request];
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
