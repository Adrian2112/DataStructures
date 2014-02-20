#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "ILLinkedList.h"

SpecBegin(ILLinkedListSpecs)

describe(@"ILLinkedList", ^{
    __block ILLinkedList *linkedList;
    
    beforeEach(^{
        linkedList = [[ILLinkedList alloc] init];
    });
    
    context(@"Linked list initialization", ^{
        it(@"should have a nil first object", ^{
            expect([linkedList firstObject]).to.beNil;
        });
        
        it(@"should have a nil last object", ^{
            expect([linkedList lastObject]).to.beNil;
        });
        
        it(@"should be empty", ^{
            expect([linkedList isEmpty]).to.beNil;
        });
    });
    
    describe(@"-insertObject:atIndex:", ^{
        __block NSString *object = @"the object";
        context(@"with empty list", ^{
            context(@"at index = 0", ^{
                beforeEach(^{
                    [linkedList insertObject:object atIndex:0];
                });
            
                it(@"should have the first object to the inserted object", ^{
                    expect([linkedList firstObject]).to.equal(object);
                });
                
                it(@"should have the last object to inserted object", ^{
                    expect([linkedList lastObject]).to.equal(object);
                });
            
                it(@"should have a length of 1", ^{
                    expect([linkedList length]).to.equal(1);
                });
            });
            
            context(@"at index > 0", ^{
                it(@"raise an 'Invalid index' error", ^{
                    expect(^{
                        [linkedList insertObject:object atIndex:1];
                    }).to.raise(@"Invalid index");
                });
            });
            
        });
        
        context(@"list with objects", ^{
            __block NSString *firstObject = @"firstObject";
            __block NSString *secondObject = @"secondObject";
            __block NSString *thirdObject = @"thirdObject";
            beforeEach(^{
                [linkedList appendObject:firstObject];
                [linkedList appendObject:secondObject];
                [linkedList appendObject:thirdObject];
            });
            
            context(@"at index > length", ^{
                it(@"raise an 'Invalid index' error", ^{
                    expect(^{
                        [linkedList insertObject:object atIndex:[linkedList length]+1];
                    }).to.raise(@"Invalid index");
                });
            });
            
            context(@"at index < length", ^{
                beforeEach(^{
                    [linkedList insertObject:object atIndex:2];
                });
                
                it(@"should add object at specified index", ^{
                    expect([linkedList objectAtIndex:2]).to.equal(object);
                });
                
                it(@"should add one to length", ^{
                    expect([linkedList length]).to.equal(4);
                });
            });
            
        });
        
    });
    
    describe(@"-removeObjectAtIndex:", ^{
        context(@"with empty list", ^{
            it(@"raise an 'Invalid index' error", ^{
                expect(^{
                    [linkedList removeObjectAtIndex:3];
                }).to.raise(@"Invalid index");
            });
        });
        
        context(@"list with objects", ^{
            __block NSString *firstObject = @"firstObject";
            __block NSString *secondObject = @"secondObject";
            __block NSString *thirdObject = @"thirdObject";
            beforeEach(^{
                [linkedList appendObject:firstObject];
                [linkedList appendObject:secondObject];
                [linkedList appendObject:thirdObject];
            });

            context(@"at index >= length", ^{
                it(@"raise an 'Invalid index' error", ^{
                    expect(^{
                        [linkedList removeObjectAtIndex:[linkedList length]];
                    }).to.raise(@"Invalid index");
                });
            });

            context(@"at index < length", ^{
                __block id removedObject;
                beforeEach(^{
                    removedObject = [linkedList removeObjectAtIndex:1];
                });
                
                it(@"should return the removed object", ^{
                    expect(removedObject).to.equal(secondObject);
                });
                
                it(@"should substract one to length", ^{
                    expect([linkedList length]).to.equal(2);
                });
            });
            
        });
        
    });
    
    
    describe(@"-removeFirstObject:", ^{
        context(@"with empty list", ^{
            it(@"raise an 'Invalid index' error", ^{
                expect(^{
                    [linkedList removeObjectAtIndex:1];
                }).to.raise(@"Invalid index");
            });
        });
        
        context(@"list with objects", ^{
            __block NSString *firstObject = @"firstObject";
            __block NSString *secondObject = @"secondObject";
            __block NSString *thirdObject = @"thirdObject";
            
            __block id removedObject;
            beforeEach(^{
                [linkedList appendObject:firstObject];
                [linkedList appendObject:secondObject];
                [linkedList appendObject:thirdObject];
                
                removedObject = [linkedList removeFirstObject];
            });

            it(@"should return the removed object", ^{
                expect(removedObject).to.equal(firstObject);
            });
            
            it(@"should substract one to length", ^{
                expect([linkedList length]).to.equal(2);
            });
        });
        
    });
    
    describe(@"-removeLastObject:", ^{
        context(@"with empty list", ^{
            it(@"raise an 'Invalid index' error", ^{
                expect(^{
                    [linkedList removeObjectAtIndex:1];
                }).to.raise(@"Invalid index");
            });
        });
        
        context(@"list with objects", ^{
            __block NSString *firstObject = @"firstObject";
            __block NSString *secondObject = @"secondObject";
            __block NSString *thirdObject = @"thirdObject";
            
            __block id removedObject;
            beforeEach(^{
                [linkedList appendObject:firstObject];
                [linkedList appendObject:secondObject];
                [linkedList appendObject:thirdObject];
                
                removedObject = [linkedList removeLastObject];
            });

            it(@"should return the removed object", ^{
                expect(removedObject).to.equal(thirdObject);
            });
            
            it(@"should substract one to length", ^{
                expect([linkedList length]).to.equal(2);
            });
        });
        
    });
    
    describe(@"-includeObject:", ^{
        __block NSString *firstObject = @"firstObject";
        __block NSString *secondObject = @"secondObject";
        __block NSString *notIncludedObject = @"thirdObject";
        
        beforeEach(^{
            [linkedList appendObject:firstObject];
            [linkedList appendObject:secondObject];
        });
        
        context(@"it has the object", ^{
            it(@"should return YES", ^{
                expect([linkedList includeObject:firstObject]).to.beFalsy;
            });
        });
        
        context(@"it does not have the object", ^{
            it(@"should return NO", ^{
                expect([linkedList includeObject:notIncludedObject]).to.beFalsy;
            });
        });
    });
    
});

SpecEnd