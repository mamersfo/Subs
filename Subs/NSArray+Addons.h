//
//  NSArray+Addons.h
//  Subs
//
//  Created by Martin van Amersfoorth on 9/18/12.
//  Copyright (c) 2012 Martin van Amersfoorth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Addons)

- (NSArray *)shuffle;
- (NSArray *)intersection:(NSArray *)other;
- (NSArray *)difference:(NSArray *)other;

@end
