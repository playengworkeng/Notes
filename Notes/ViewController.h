//
//  ViewController.h
//  Notes
//
//  Created by J on 8/11/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "Model.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate>
-(void)tappedSave:(UIButton*)sender;
-(void)doThatThing:(void(^)())completionHandler;
-(id)initWithNote:(Note*)note;
@end

