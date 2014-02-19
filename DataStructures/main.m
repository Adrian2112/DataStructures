//
//  main.m
//  DataStructures
//
//  Created by Adrian Gonzalez on 2/19/14.
//  Copyright (c) 2014 Adrian Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILDictionary.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
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
    
    return 0;
}