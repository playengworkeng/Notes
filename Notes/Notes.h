//
//  Notes.h
//  Notes
//
//  Created by J on 8/13/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
@interface Notes : NSObject

@property (strong, nonatomic)NSMutableArray* notes;
-(id)initWithNotes:(NSArray*)notes;
-(NSInteger)count;
-(Note*)getNoteAtIndex:(NSInteger)index;
-(void)addNote:(Note*)note;
-(Note*)deleteNodeAtIndex:(NSInteger)index;
-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end
