//
//  Note.m
//  Notes
//
//  Created by J on 8/12/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import "Note.h"

@implementation Note

-(id)initWithTitle:(NSString*)title detail:(NSString*)detail
{
    self = [super init];
    if(!self)
    {
        return nil;
    }
    
    self.title = title;
    self.detail = detail;
    
    return self;
    
}
@end
