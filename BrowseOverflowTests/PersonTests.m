//
//  PersonTests.m
//  BrowseOverflow
//
//  Created by Chang Chia-huai on 10/6/12.
//  Copyright (c) 2012 Chang Chia-huai. All rights reserved.
//

#import "PersonTests.h"
#import "Person.h"

@implementation PersonTests {
    Person *person;
}

- (void)setUp {
    person = [[Person alloc] initWithName:@"Graham" avatarLocation:@"http://example.com/avatar.png"];
}

- (void)tearDown {
    person = nil;
}

- (void)testThatPersonHasTheRightName {
    STAssertEqualObjects(person.name, @"Graham", @"expecting a person to provide its name");
}

- (void)testThatPersonHasAnAvatarURL {
    NSURL *url = person.avatarURL;
    STAssertEqualObjects([url absoluteString], @"http://example.com/avatar.png", @"The person's avatar should be represented by a URL");
}

@end
