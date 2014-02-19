//
//  ILLinkedList.m
//  DataStructures
//
//  Created by Adrian Gonzalez on 2/19/14.
//  Copyright (c) 2014 Adrian Gonzalez. All rights reserved.
//

#import "ILLinkedList.h"

#pragma mark - ILNode

@interface ILNode : NSObject
@property (strong, nonatomic) id object;
@property (strong, nonatomic) ILNode *next;

-(instancetype)initWithObject:(id)object;
@end

@implementation ILNode

- (id)initWithObject:(id)object
{
    self = [super init];
    if (self) {
        self.object = object;
        self.next = nil;
    }
    return self;
}

@end

#pragma mark - ILLinkedList

@interface ILLinkedList ()
@property (strong, nonatomic) ILNode *first;
@property (strong, nonatomic) ILNode *last;
@end

@implementation ILLinkedList

- (id)init
{
    self = [super init];
    if (self) {
        self.first = nil;
        self.last = nil;
    }
    return self;
}

-(NSString *)description
{
    NSMutableString *description = [NSMutableString string];
    
    // fake node to iterate the while with assignation
    ILNode *currentNode = [[ILNode alloc] init];
    currentNode.next = self.first;
    
    while ((currentNode = currentNode.next)) {
        [description appendFormat:@"%@ -> ", currentNode.object];
    }
    
    return [description copy];
}

#pragma mark - insert object

-(void)appendObject:(id)object
{
    ILNode *node = [[ILNode alloc] initWithObject:object];
    node.next = nil;
    
    // if list is empty
    if ([self isEmpty]) {
        self.first = self.last = node;
    } else {
        self.last.next = node;
        self.last = node;
    }
}

-(void)prependObject:(id)object
{
    ILNode *node = [[ILNode alloc] initWithObject:object];
    node.next = self.first;
    self.first = node;
}

-(void)insertObject:(id)object atIndex:(NSUInteger)index
{
    ILNode *newNode = [[ILNode alloc] initWithObject:object];
    
    ILNode *previousNode = [self previousNodeAtIndex:index];
    
    ILNode *nextNode = previousNode.next;
    
    newNode.next = nextNode;
    previousNode.next = newNode;
}

#pragma mark - remove objects

-(id)removeFirstObject
{
    ILNode *firstNode = self.first;
    self.first = firstNode.next;
    
    return firstNode.object;
}

-(id)removeLastObject
{
    ILNode *lastNode = self.last;
    
    ILNode *newLastNode = self.first;
    while (newLastNode.next != lastNode) {
        newLastNode = newLastNode.next;
    }
    
    self.last = newLastNode;
    newLastNode.next = nil;
    
    return lastNode.object;
}

-(id)removeObjectAtIndex:(NSUInteger)index
{
    if (index == 0) {
        return [self removeFirstObject];
    }
    
    ILNode *previosNodeToRemove = [self previousNodeAtIndex:index];
    
    ILNode *nodeToRemove = previosNodeToRemove.next;
    previosNodeToRemove.next = nodeToRemove.next;
    
    return nodeToRemove.object;
}

#pragma mark - object accessors

-(BOOL)isEmpty
{
    return self.first == nil;
}

#pragma mark - helpers

-(ILNode *)previousNodeAtIndex:(NSUInteger)index
{
    if (index <= 0) {
        return self.first;
    }
    
    ILNode *previosNode = self.first;
    NSUInteger currentIndex = 0;
    
    while(previosNode.next && currentIndex < index - 1) {
        previosNode = previosNode.next;
        currentIndex++;
    }
    
    return previosNode;
}

-(ILNode *)nodeAtIndex:(NSUInteger)index
{
    return [self previousNodeAtIndex:index].next;
}

@end
