//
//  PersonBuilder.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/9/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "PersonBuilder.h"
#import "Person.h"

@implementation PersonBuilder

+ (Person *)personFromDictionary:(NSDictionary *)ownerValues {
    NSString *name = [ownerValues objectForKey:@"display_name"];
    NSString *avatarURL = [NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@", [ownerValues objectForKey:@"email_hash"]];
    Person *owner = [[Person alloc] initWithName:name avatarLocation:avatarURL];
    return owner;
}

@end
