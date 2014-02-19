//
//  ILDictionary.m
//  DataStructures
//
//  Created by Adrian Gonzalez on 2/19/14.
//  Copyright (c) 2014 Adrian Gonzalez. All rights reserved.
//

#import "ILDictionary.h"

#pragma mark - KeyValue

@interface ILKeyValue : NSObject

@property (strong, nonatomic) id key;
@property (strong, nonatomic) id value;

-initWithKey:(id)key value:(id)value;

@end

@implementation ILKeyValue

- (id)initWithKey:(id)key value:(id)value
{
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
    }
    return self;
}

@end

#pragma mark - ILDictionary

#define NUMBER_OF_BUCKETS 5

@class ILKeyValue;

@interface ILDictionary ()

@property (strong, nonatomic) NSArray *buckets;

@end

@implementation ILDictionary

- (id)init
{
    self = [super init];
    if (self) {
        [self initializeBuckets];
    }
    return self;
}

- (void)initializeBuckets
{
    NSMutableArray *buckets = [NSMutableArray arrayWithCapacity:NUMBER_OF_BUCKETS];
    for (int i = 0; i < NUMBER_OF_BUCKETS; i++) {
        buckets[i] = [NSMutableArray array];
    }
    
    self.buckets = [buckets copy];
}

-(NSString *)description
{
    __block NSMutableString *description = [NSMutableString string];
    
    [self.buckets enumerateObjectsUsingBlock:^(NSMutableArray *bucket, NSUInteger index, BOOL *stop) {
        NSMutableString *bucketString = [NSMutableString string];
        for (ILKeyValue *bucketKeyValue in bucket) {
            [bucketString appendFormat:@"%@, ", bucketKeyValue.value];
        }
        [description appendFormat:@"%lu -> %@\n", (unsigned long)index, bucketString];
    }];
    
    return [description copy];
}

# pragma mark -

-(void)setObject:(id)object forKey:(id)key
{
    NSMutableArray *bucket = [self bucketForKey:key];
    ILKeyValue *keyValue = [[ILKeyValue alloc] initWithKey:key value:object];
    [bucket addObject:keyValue];
}

-(id)objectForKey:(id)key
{
    NSMutableArray *bucket = [self bucketForKey:key];
    __block id object = nil;
    [bucket enumerateObjectsUsingBlock:^(ILKeyValue *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.key isEqualTo:key]) {
            object = obj.value;
            *stop = YES;
        }
    }];
    
    return object;
}

-(NSMutableArray *)bucketForKey:(id)key
{
    NSUInteger bucketIndex = [(NSObject *)key hash] % NUMBER_OF_BUCKETS;
    return self.buckets[bucketIndex];
}

@end


