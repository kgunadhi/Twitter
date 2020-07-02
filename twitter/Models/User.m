//
//  User.m
//  twitter
//
//  Created by Kaitlyn Gunadhi on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        NSString *profileURLString = [dictionary[@"profile_image_url_https"] stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
        self.profileImage = [NSURL URLWithString:profileURLString];
    }
    return self;
}

@end
