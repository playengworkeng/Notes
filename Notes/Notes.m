//
//  Notes.m
//  Notes
//
//  Created by J on 8/13/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import "Notes.h"

@implementation Notes


-(id)initWithNotes:(NSArray *)notes
{

    self = [super init];
    
    if(!self)
    {
        return nil;
    }
    
    
    self.notes = [notes mutableCopy];
    
    return self;
    
    
}



-(void)addNote:(Note *)note

{
    
    [self.notes addObject:note];
    
    
}


-(Note*)getNoteAtIndex:(NSInteger)index
{
    
    Note* note = [self.notes objectAtIndex:index];
    
    return note;
}


-(Note*)deleteNodeAtIndex:(NSInteger)index
{
    
    Note* note = [self.notes objectAtIndex:index];
    [self.notes removeObjectAtIndex:index];
    
    return note;
    
}


-(void)moveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    
    Note* noteFrom = [self.notes objectAtIndex:fromIndex];
    Note* noteTo = [self.notes objectAtIndex:toIndex];
    
    [self.notes insertObject:noteFrom atIndex:toIndex];
    [self.notes insertObject:noteTo atIndex:fromIndex];
    
    
    
}

-(NSInteger)count{
    
    NSInteger count = [self.notes count];
    
    return count;
    
}




@end
