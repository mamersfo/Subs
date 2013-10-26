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

- (NSArray *)intersection:(NSArray *)other
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for ( id anObject in self )
    {
        if ( [other containsObject:anObject] )
        {
            [result addObject:anObject];
        }
    }
    
    return result;
}

- (NSArray *)difference:(NSArray *)other
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for ( id anObject in self )
    {
        if ( [other containsObject:anObject] == NO )
        {
            [result addObject:anObject];
        }
    }
    
    return result;
}

@end
