//
//  main.m
//  DataStructures
//
//  Created by Adrian Gonzalez on 2/19/14.
//  Copyright (c) 2014 Adrian Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILDictionary.h"
#import "ILLinkedList.h"

void dictionaryTest();
void linkedListTest();

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        linkedListTest();
    }
    
    return 0;
}

void dictionaryTest()
{
    ILDictionary *dic = [[ILDictionary alloc] init];
    for (int i = 0; i < 8; i++) {
        NSString *key = [NSString stringWithFormat:@"%d", arc4random()];
        NSNumber *value = @(i);
        [dic setObject:value forKey:key];
    }
    
    NSLog(@"\n%@", dic);
    
    NSNumber *obj = [dic objectForKey:@"32"];
    NSLog(@"%@", obj);
}

void linkedListTest()
{
    ILLinkedList *ll = [[ILLinkedList alloc] init];
    
    for (int i = 1; i < 10; i++) {
        NSString *object = [NSString stringWithFormat:@"%d", i];
        [ll appendObject:object];
    }
    
    [ll prependObject:@0];
    [ll insertObject:@11 atIndex:3];
    
    NSLog(@"%@", ll);
    
}