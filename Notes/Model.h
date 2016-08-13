//
//  Model.h
//  Notes
//
//  Created by J on 8/12/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
@class Note;

@interface Model : NSObject
+(Model*)sharedModel;

-(void)saveNote:(Note*)note;
-(Note*)loadNote;

@end
