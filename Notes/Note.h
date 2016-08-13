//
//  Note.h
//  Notes
//
//  Created by J on 8/12/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Note;
@interface Note : NSObject

@property(strong, nonatomic)NSString* title;
@property(strong, nonatomic)NSString* detail;

-(id)initWithTitle:(NSString*)title detail:(NSString*)detail;


@end
