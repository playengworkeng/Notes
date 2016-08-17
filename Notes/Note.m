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



-(BOOL)isBlank
{
    
    
    return !(self.title && self.title.length>0 && self.detail && self.detail.length>0);
}


#pragma mark - NSCoding

-(void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.detail forKey:@"detail"];
}




-(id)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    self.title = [coder decodeObjectForKey:@"title"];
    self.detail = [coder decodeObjectForKey:@"detail"];
    
    return self;
    
}
@end
