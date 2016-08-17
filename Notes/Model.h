//
//  Model.h
//  Notes
//
//  Created by J on 8/12/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Notes.h"
#import "Note.h"
@class Note;

@interface Model : NSObject
@property(strong, nonatomic)Notes* notes;
+(Model*)sharedModel;

-(void)saveNotes;
-(Notes*)notes;
//-(void)SaveNote:(Note*)note;
//-(Note*)loadNote;

@end
