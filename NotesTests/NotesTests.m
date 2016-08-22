//
//  NotesTests.m
//  NotesTests
//
//  Created by J on 8/13/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Note.h"
#import "Notes.h"

@interface NotesTests : XCTestCase
@property (strong, nonatomic)Note* note1;
@property (strong, nonatomic)Note* note2;
@property (strong, nonatomic)Notes* notes;

@end

@implementation NotesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [super setUp];
    self.note1 = [[Note alloc] initWithTitle:@"First note" detail:@"Here's some detail"];
    self.note2 = [[Note alloc] initWithTitle:@"Second note" detail:@"Here's some more detail"];
    self.notes = [[Notes alloc] initWithNotes:@[self.note1, self.note2]];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


-(void)testAddNote{
    BOOL testAddNote;
    NSInteger notecount = self.notes.count;
    Note* note3 = [[Note alloc]initWithTitle:@"newTitle" detail:@"newDetail"];
    [self.notes addNote:note3];

    if(self.notes.count > notecount)
    {
        
        testAddNote = YES;
        NSLog(@"testAddNote Passed");
    }
    
    XCTAssertTrue(testAddNote, @"testAddNote Passed");

}


-(void)testGetNodeAtIndex{
    
    BOOL testGetNode;
    Note* note = [self.notes getNoteAtIndex:0];
    
    if(note == self.note1)
    {
        
        testGetNode = YES;
        NSLog(@"testGetNodeAtIndex Passed");
        
    }
    
    XCTAssertTrue(testGetNode, @"testGetNodeAtIndex Passed");
    
}


-(void)testDeleteNoteAtIndex{
    
    BOOL testDeleteNote;
    
    NSInteger noteCount = self.notes.count;
    
    Note* noteReturn = [self.notes deleteNodeAtIndex:0];
    
    if ([self.notes getNoteAtIndex:0] != noteReturn && self.notes.count < noteCount)
    {
        
        testDeleteNote =TRUE;
        NSLog(@"testDeleteNodeAtIndex Passed");
    }
    
    XCTAssertTrue(testDeleteNote, @"testDeleteNodeAtIndex Passed");
    
}


-(void)testMoveFromIndex{
    
    BOOL testMoveFromTo;
    [self.notes moveFromIndex:0 toIndex:1];
    Note* getNote1 = [self.notes getNoteAtIndex:0];
    Note* getNote2 = [self.notes getNoteAtIndex:1];
    
    if (getNote2== self.note1 && getNote1 == self.note2)
    {
        
        testMoveFromTo = YES;
        NSLog(@"testMoveFromIndex Passed");
    }
    
    XCTAssertTrue(testMoveFromTo, @"testGetNodeAtIndex Passed");
    
    
}



@end
