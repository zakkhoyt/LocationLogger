//
//  VWWMapViewController.m
//  LocationLogger
//
//  Created by Zakk Hoyt on 10/21/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWMapViewController.h"
@import MapKit;
#import "VWW.h"
#import "VWWAnnotation.h"
#import "VWWSignificantLocationController.h"

@interface VWWMapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *coordinateDictionaries;
@property (nonatomic, strong) NSMutableArray *errorPolygons;
@end

@implementation VWWMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.errorPolygons = [@[]mutableCopy];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.798766, -122.449373), span);
    [self.mapView setRegion:region animated:NO];
    self.mapView.delegate = self;
    [self reloadCoordinates];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:VWWSignificantLocationControllerNewLocationKey object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self reloadCoordinates];
    }];

    [[NSNotificationCenter defaultCenter] addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self reloadCoordinates];
    }];

}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadCoordinates{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.coordinateDictionaries = [VWWUserDefaults coordinates];

    NSMutableArray *annotations = [[NSMutableArray alloc]initWithCapacity:self.coordinateDictionaries.count];
    for(NSDictionary *dictionary in self.coordinateDictionaries){
        NSNumber *latitudeNumber = dictionary[@"latitude"];
        NSNumber *longitudeNumber = dictionary[@"longitude"];
        NSNumber *altitudeNumber = dictionary[@"altitude"];
        NSNumber *horizontalAccuracyNumber = dictionary[@"horizontalAccuracy"];
        NSNumber *verticalAccuracyNumber = dictionary[@"verticalAccuracy"];
        NSDate *date = dictionary[@"date"];

        VWWAnnotation *annotation = [[VWWAnnotation alloc]init];
        NSString *accuracy = dictionary[@"accuracy"];
        if([accuracy isEqualToString:@"significant"]){
            annotation.colorIndex = 1;
        } else if([accuracy isEqualToString:@"accurate"]) {
            annotation.colorIndex = 2;
        } else {
            annotation.colorIndex = 0;
        }
        [annotation setCoordinate:CLLocationCoordinate2DMake(latitudeNumber.floatValue, longitudeNumber.floatValue)];
        [annotations addObject:annotation];
        
        CLLocation *location = [[CLLocation alloc]initWithCoordinate:CLLocationCoordinate2DMake(latitudeNumber.doubleValue, longitudeNumber.doubleValue)
                                                            altitude:altitudeNumber.doubleValue
                                                  horizontalAccuracy:horizontalAccuracyNumber.doubleValue
                                                    verticalAccuracy:verticalAccuracyNumber.doubleValue
                                                           timestamp:date];
        [self addErrorPolygonForLocation:location];

    }

    [self.mapView addAnnotations:annotations];

    
    
}


-(void)addErrorPolygonForLocation:(CLLocation*)location{
    MKCircle *errorCircle = [MKCircle circleWithCenterCoordinate:location.coordinate radius:location.horizontalAccuracy];
    [self.mapView addOverlay:errorCircle];
    
}






#pragma mark MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    if([annotation isKindOfClass:[VWWAnnotation class]]){
        VWWAnnotation *vwwAnnotation = (VWWAnnotation*)annotation;
        if(vwwAnnotation.colorIndex == 0){
            annotationView.pinColor = MKPinAnnotationColorRed;
        } else if(vwwAnnotation.colorIndex == 1){
            annotationView.pinColor = MKPinAnnotationColorGreen;
        } else if(vwwAnnotation.colorIndex == 2){
            annotationView.pinColor = MKPinAnnotationColorPurple;
        }
    }
    return annotationView;
}

#pragma mark MKMapViewDelegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay{
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc]initWithCircle:(MKCircle*)overlay];
    renderer.lineWidth = 1.0;
    renderer.strokeColor = [UIColor cyanColor];
    renderer.fillColor = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.1];
    return renderer;
    
}


@end
