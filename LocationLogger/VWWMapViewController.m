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
#import "VWWLocationController.h"

@interface VWWMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSArray *coordinateDictionaries;
@end

@implementation VWWMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MKCoordinateSpan span = MKCoordinateSpanMake(0.5, 0.5);
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.798766, -122.449373), span);
    [self.mapView setRegion:region animated:NO];
    [self reloadCoordinates];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:VWWLocationControllerNewLocationKey object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)reloadCoordinates{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    self.coordinateDictionaries = [VWWUserDefaults coordinates];

    NSMutableArray *annotations = [[NSMutableArray alloc]initWithCapacity:self.coordinateDictionaries.count];
    for(NSDictionary *dictionary in self.coordinateDictionaries){
        NSNumber *latitudeNumber = dictionary[@"latitude"];
        NSNumber *longitudeNumber = dictionary[@"longitude"];
//        NSNumber *horizontalAccuracyNumber = dictionary[@"horizontalAccuracy"];
//        NSNumber *verticalAccuracyNumber = dictionary[@"verticalAccuracy"];
//        NSDate *date = dictionary[@"date"];
        
        VWWAnnotation *annotation = [[VWWAnnotation alloc]init];
        [annotation setCoordinate:CLLocationCoordinate2DMake(latitudeNumber.floatValue, longitudeNumber.floatValue)];
        [annotations addObject:annotation];
    }

    [self.mapView addAnnotations:annotations];
    
}

#pragma mark MKMapViewDelegate


@end
