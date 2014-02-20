//
//  ILLinkedList.h
//  DataStructures
//
//  Created by Adrian Gonzalez on 2/19/14.
//  Copyright (c) 2014 Adrian Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ILLinkedList : NSObject

-(void)appendObject:(id)object;
-(void)prependObject:(id)object;
-(void)insertObject:(id)object atIndex:(NSUInteger)index;

-(id)removeLastObject;
-(id)removeFirstObject;
-(id)removeObjectAtIndex:(NSUInteger)index;

-(NSUInteger)length;
-(BOOL)isEmpty;
-(id)firstObject;
-(id)lastObject;
-(id)objectAtIndex:(NSUInteger)index;

@end
