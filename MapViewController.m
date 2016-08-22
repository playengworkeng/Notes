//
//  MapViewController.m
//  Notes
//
//  Created by J on 8/20/16.
//  Copyright © 2016 Thinkful. All rights reserved.
//

#import "MapViewController.h"
#import "Note.h"



@interface MapViewController ()


@end

@implementation MapViewController

-(id)init{
    
    self = [super init];
    
    if (!self){
        
        return nil;
    }
    
    self.title = @"Maps";
    

    self.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"Map" image:[UIImage imageNamed:@"Map"] tag:0 ];
    
    return self;
    
    
    
}

-(void)initWithNoteAnnotations:(NSArray *)notes {
    
    
    self.notes = notes;

}

-(void)createNoteAnnotations {
    
    
    
    int i =0;
    for (Note* n in self.notes)
    {
        MKPointAnnotation* anNote = [[MKPointAnnotation alloc]init];
        
        anNote.title = n.title;
        anNote.subtitle = n.detail;
        anNote.coordinate = CLLocationCoordinate2DMake((CLLocationDegrees)n.latitude.doubleValue, (CLLocationDegrees)n.longitude.doubleValue);
    

    
        [self.annotations insertObject:anNote atIndex:i];
    
        i++;
        
        NSLog(@"%@", anNote.title);
 
        
    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.notes = [[Model sharedModel]notes].notes;
    
    UISegmentedControl* segControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(25, 50, 200, 50)];
    [segControl addTarget:self action:@selector(changeMap:) forControlEvents:UIControlEventValueChanged];
    MKMapView* mapView = [[MKMapView alloc]initWithFrame:self.view.frame];
    
    [segControl insertSegmentWithTitle:@"MapType1" atIndex:0 animated:YES];
    [segControl insertSegmentWithTitle:@"MapType2" atIndex:1 animated:YES];
    [segControl insertSegmentWithTitle:@"MapType3" atIndex:2 animated:YES];
    
    mapView.mapType = MKMapTypeHybrid;
    
    self.annotations = [[NSMutableArray alloc]init];

    self.mapView = mapView;
    self.mapView.delegate = self;

   
    self.mapSegControl = segControl;
    [self createNoteAnnotations];
    [self setResponseForTapAndHold];
    [self.mapView addAnnotations:self.annotations];
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.mapSegControl];
   

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(void)changeMap:(UISegmentedControl*)sender {
    
    
    if ([sender selectedSegmentIndex] == 0)
    {
        NSLog(@"I got a ceneter segment");
        self.mapView.mapType = MKMapTypeHybrid;
        
    }
    
    else
    {
        self.mapView.mapType = MKMapTypeStandard;
    }
    
    
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    
    UIImage* uberBadge = [UIImage imageNamed:@"Badge"];
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:uberBadge forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, uberBadge.size.width, uberBadge.size.height);
    leftButton.tag = 1;
    
    
    if([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
        
    }
    
    else if([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        
        MKPinAnnotationView* pinView= (MKPinAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinView"];
        
        if (!pinView)
        {
            
            pinView = [[MKPinAnnotationView alloc]init];
            pinView.pinTintColor = [UIColor purpleColor];
            pinView.leftCalloutAccessoryView = leftButton;
            pinView.canShowCallout = YES;
            
        }
        
        else{
            pinView.pinTintColor = [UIColor purpleColor];
            pinView.leftCalloutAccessoryView = leftButton;
            pinView.annotation = annotation;
     
            
            
 
        }
        
        return pinView;

    }
    
    return nil;
    
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    MKPointAnnotation* annotation = (MKPointAnnotation*)view.annotation;
    

    
    
    if(control.tag == 1)
    {
        
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"uber://"]])
        {
            NSLog(@"%f, %f",annotation.coordinate.longitude, annotation.coordinate.latitude);
            NSString* url = [NSString stringWithFormat:@"uber://?action=setPickup&pickup=my_location&&dropoff[latitude]=%f&dropoff[longitude]=%f", (float)annotation.coordinate.latitude, (float)annotation.coordinate.longitude];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
            
            
            
        } else{
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://m.uber.com"]];
             NSLog(@"%f, %f",annotation.coordinate.latitude, annotation.coordinate.longitude);
        }
        
        
    } else{
        
        
    }
    

}

-(void)setResponseForTapAndHold{
    
    UILongPressGestureRecognizer* getsureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(didDropPin:)];
    
    [self.mapView addGestureRecognizer:getsureRecognizer];
    
}



-(void)didDropPin:(UIGestureRecognizer*)gestureRecognizer
{
    
    
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        
    
    CGPoint point = [gestureRecognizer locationInView:self.mapView];
    
        CLLocationCoordinate2D mapCoordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        MKPointAnnotation* annotationPoint = [[MKPointAnnotation alloc]init];
        
        annotationPoint.coordinate = mapCoordinate;
        
        [self.mapView addAnnotation:annotationPoint];
    }
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
