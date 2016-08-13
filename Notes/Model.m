//
//  Model.m
//  Notes
//
//  Created by J on 8/12/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#include "Model.h"

@implementation Model

+(Model*)sharedModel
{
    
    static Model* modelSingleton;
    static dispatch_once_t once;
    dispatch_once(&once, ^{modelSingleton = [[Model alloc]init];});
    
    return modelSingleton;
    
}


-(void)saveNote:(Note*)note
{
    //Saving data using a dictionary of sorts, have to call synchronized for threading purposes
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:note.title forKey:@"title"];
    [defaults setObject:note.title forKey:@"detail"];
    [defaults synchronize];
                                   
    
}


-(Note*)loadNote{
    
    Note* note;
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* title = [defaults stringForKey:@"title"];
    NSString* detail = [defaults stringForKey:@"detail"];
    
    if (title && detail)
    {
        note = [[Note alloc]initWithTitle:title detail:detail];
    
    }
    
    else{
        
        note = [[Note alloc]initWithTitle:@"" detail:@""];
    }
    
    
    
    return note;
    
    
}

@end
