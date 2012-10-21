//
//  NSArray+Addons.m
//  Subs
//
//  Created by Martin van Amersfoorth on 9/18/12.
//  Copyright (c) 2012 Martin van Amersfoorth. All rights reserved.
//

#import "NSArray+Addons.h"

@implementation NSArray (Addons)

- (NSArray *)shuffle
{
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:[self count]];
    
    for ( id anObject in self )
    {
        NSUInteger randomPos = arc4random() % ([tmp count]+1);
        [tmp insertObject:anObject atIndex:randomPos];
    }
    
    return [NSArray arrayWithArray:tmp];
}

@end
