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
@property (assign, nonatomic) NSUInteger length;
@end

@implementation ILLinkedList

- (id)init
{
    self = [super init];
    if (self) {
        self.first = nil;
        self.last = nil;
        self.length = 0;
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
    [self insertObject:object atIndex:self.length];
}

-(void)prependObject:(id)object
{
    [self insertObject:object atIndex:0];
}

-(void)insertObject:(id)object atIndex:(NSUInteger)index
{
    ILNode *newNode = [[ILNode alloc] initWithObject:object];
    
    [self validateInsertionAtIndex:index];
    
    self.length++;
    
    // if list is empty
    if ([self isEmpty]) {
        self.first = self.last = newNode;
        return;
    }
    
    // insert at beginning
    if (index == 0) {
        newNode.next = self.first;
        self.first = newNode;
        return;
    }
    // insert at last
    else if (index == self.length-1) {
        self.last = newNode;
    }
    
    ILNode *previousNode = [self previousNodeAtIndex:index];
    
    ILNode *nextNode = previousNode.next;
    
    newNode.next = nextNode;
    previousNode.next = newNode;
}

#pragma mark - remove objects

-(id)removeFirstObject
{
    [self validateRemoveAtIndex:0];
    ILNode *firstNode = self.first;
    self.first = firstNode.next;
    self.length--;
    return firstNode.object;
}

-(id)removeLastObject
{
    [self validateRemoveAtIndex:self.length-1];
    
    ILNode *lastNode = self.last;
    
    ILNode *newLastNode = self.first;
    while (newLastNode.next != lastNode) {
        newLastNode = newLastNode.next;
    }
    
    self.last = newLastNode;
    newLastNode.next = nil;
    
    self.length--;
    return lastNode.object;
}

-(id)removeObjectAtIndex:(NSUInteger)index
{
    [self validateRemoveAtIndex:index];
    
    if (index == 0) {
        return [self removeFirstObject];
    }
    
    ILNode *previosNodeToRemove = [self previousNodeAtIndex:index];
    
    ILNode *nodeToRemove = previosNodeToRemove.next;
    previosNodeToRemove.next = nodeToRemove.next;
    self.length--;
    
    return nodeToRemove.object;
}

#pragma mark - object accessors

-(BOOL)isEmpty
{
    return self.first == nil;
}

-(id)firstObject
{
    return self.first.object;
}

-(id)lastObject
{
    return self.last.object;
}

-(id)objectAtIndex:(NSUInteger)index
{
    return [self nodeAtIndex:index].object;
}

-(BOOL)includeObject:(id)object
{
    ILNode *currentNode = [[ILNode alloc] init];
    currentNode.next = self.first;
    
    while ((currentNode = currentNode.next)) {
        if ([currentNode.object isEqualTo:object]) {
            return YES;
        }
    }
    
    return NO;
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

-(void)validateInsertionAtIndex:(NSUInteger)index
{
    if ([self isEmpty] && index > 0) {
        [NSException raise:@"Invalid index" format:@"Trying to insert object at index %lu in an empty list", (unsigned long)index];
    }
    
    if (index > self.length) {
        [NSException raise:@"Invalid index" format:@"Trying to insert object at index %lu in a list with %lu elements", (unsigned long)index, (unsigned long)self.length];
    }
    
}

-(void)validateRemoveAtIndex:(NSUInteger)index
{
    if ([self isEmpty]) {
        [NSException raise:@"Invalid index" format:@"Trying to remove object at index %lu in an empty list", (unsigned long)index];
    }
    
    if (index >= self.length) {
        [NSException raise:@"Invalid index" format:@"Trying to remove object at index %lu in a list with %lu elements", (unsigned long)index, (unsigned long)self.length];
    }
}

@end
