//
//  MapViewController.h
//  Notes
//
//  Created by J on 8/20/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Note.h"
#import "Notes.h"
#import "Model.h"
#import "NotesTableViewController.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>
@property(strong, nonatomic)MKMapView* mapView;
@property(strong, nonatomic)MKPointAnnotation* noteAnnotation;
@property(strong, nonatomic)UISegmentedControl* mapSegControl;
@property(strong, nonatomic)NSArray* notes; //notes array
@property(strong, nonatomic)NSMutableArray<id<MKAnnotation>>* annotations; //annotations from notes
@property(strong, nonatomic)NSArray*  anArray;
-(void)initWithNoteAnnotations:(NSArray*)notes;

@end
