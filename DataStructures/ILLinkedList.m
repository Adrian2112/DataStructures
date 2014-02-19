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
    
    NSUInteger currentIndex = 0;
    ILNode *previousNode = self.first;
    
    // get the previous node
    while (previousNode.next && currentIndex < index - 1) {
        previousNode = previousNode.next;
        currentIndex++;
    }
    
    ILNode *nextNode = previousNode.next;
    
    newNode.next = nextNode;
    previousNode.next = newNode;
}

-(BOOL)isEmpty
{
    return self.first == nil;
}

@end
