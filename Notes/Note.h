//
//  Note.h
//  Notes
//
//  Created by J on 8/12/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Note: NSObject<NSCoding>

@property(strong, nonatomic)NSString* title;
@property(strong, nonatomic)NSString* detail;
@property(strong, nonatomic)NSNumber* latitude;
@property(strong, nonatomic)NSNumber* longitude;

-(id)initWithTitle:(NSString*)title detail:(NSString*)detail latitude:(NSNumber*)latitude longitude:(NSNumber*)longitude;
-(BOOL)isBlank;


@end
