//
//  VWWLocationController.m
//  VWWClusteredMapView
//
//  Created by Zakk Hoyt on 10/13/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSignificantLocationController.h"
#import "VWW.h"
#import "AppDelegate.h"

#import "VWWAccurateLocationController.h"

static NSString *SMLocationControllerLatitudeKey = @"latitude";
static NSString *SMLocationControllerLongitudeKey = @"longitude";


@interface VWWSignificantLocationController () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) BOOL isRunning;
@property (nonatomic, copy) CLLocation *location;
@end

@implementation VWWSignificantLocationController



#pragma mark Public methods

+(VWWSignificantLocationController*)sharedInstance{
    static VWWSignificantLocationController *instance;
    if(instance == nil){
        instance = [[VWWSignificantLocationController alloc]init];
    }
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
    }
    return self;
}






-(void)start{
    if(self.isRunning) return;
    self.isRunning = YES;
    
    [self.locationManager startMonitoringSignificantLocationChanges];
}

-(void)stop{
    if(self.isRunning == NO) return;
    self.isRunning = NO;
    
    [self.locationManager stopMonitoringSignificantLocationChanges];
    
}

-(void)acquireAccurateLocation{
    // Stop significant location changes
    
    // Configue and start nav location updates
    
    // Once a location is obtained with low error, stop nav location updates
    
    // Start significant location changes
}


-(CLLocation*)lastLocation{
    return self.location;
}

-(void)reset{
    [self stop];
    self.location = nil;
}



#pragma mark Private methods






#pragma mark CLLocationManagerDelegate



/*
 *  locationManager:didUpdateLocations:
 *
 *  Discussion:
 *    Invoked when new locations are available.  Required for delivery of
 *    deferred locations.  If implemented, updates will
 *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
 *
 *    locations is an array of CLLocation objects in chronological order.
 */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    if(locations.count){
        self.location = locations[0];
        [VWWUserDefaults addCoordinate:@{@"latitude" : @(self.location.coordinate.latitude),
                                         @"longitude" : @(self.location.coordinate.longitude),
                                         @"horizontalAccuracy" : @(self.location.horizontalAccuracy),
                                         @"verticalAccuracy" : @(self.location.verticalAccuracy),
                                         @"altitude" : @(self.location.altitude),
                                         @"speed" : @(self.location.speed),
                                         @"date" : self.location.timestamp,
                                         @"accuracy" : @"significant"}];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:VWWSignificantLocationControllerNewLocationKey object:nil];
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        [appDelegate scheduleLocalNotificationWithMessage:[NSString stringWithFormat:@"App Currently Running. S. %@", self.location.description]];
        
        [[VWWAccurateLocationController sharedInstance]start];
    }
}

/*
 *  locationManager:didUpdateHeading:
 *
 *  Discussion:
 *    Invoked when a new heading is available.
 */
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading{
    VWW_LOG_DEBUG(@"");
}

/*
 *  locationManagerShouldDisplayHeadingCalibration:
 *
 *  Discussion:
 *    Invoked when a new heading is available. Return YES to display heading calibration info. The display
 *    will remain until heading is calibrated, unless dismissed early via dismissHeadingCalibrationDisplay.
 */
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager{
    
    VWW_LOG_DEBUG(@"");
    return NO;
}

/*
 *  locationManager:didDetermineState:forRegion:
 *
 *  Discussion:
 *    Invoked when there's a state transition for a monitored region or in response to a request for state via a
 *    a call to requestStateForRegion:.
 */
- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
    VWW_LOG_DEBUG(@"");
}

/*
 *  locationManager:didEnterRegion:
 *
 *  Discussion:
 *    Invoked when the user enters a monitored region.  This callback will be invoked for every allocated
 *    CLLocationManager instance with a non-nil delegate that implements this method.
 */
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region {
    
    VWW_LOG_DEBUG(@"");
}

/*
 *  locationManager:didExitRegion:
 *
 *  Discussion:
 *    Invoked when the user exits a monitored region.  This callback will be invoked for every allocated
 *    CLLocationManager instance with a non-nil delegate that implements this method.
 */
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region{
    
    VWW_LOG_DEBUG(@"");
}

/*
 *  locationManager:didFailWithError:
 *
 *  Discussion:
 *    Invoked when an error has occurred. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    VWW_LOG_DEBUG(@"error: %@", error);
}

/*
 *  locationManager:monitoringDidFailForRegion:withError:
 *
 *  Discussion:
 *    Invoked when a region monitoring error has occurred. Error types are defined in "CLError.h".
 */
- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error{
    
    VWW_LOG_DEBUG(@"error: %@", error);
}

/*
 *  locationManager:didChangeAuthorizationStatus:
 *
 *  Discussion:
 *    Invoked when the authorization status changes for this application.
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    VWW_LOG_DEBUG(@"");
}
/*
 *  locationManager:didStartMonitoringForRegion:
 *
 *  Discussion:
 *    Invoked when a monitoring for a region started successfully.
 */
- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region {
    
    VWW_LOG_DEBUG(@"");
}

/*
 *  Discussion:
 *    Invoked when location updates are automatically paused.
 */
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    
    VWW_LOG_DEBUG(@"");
}

/*
 *  Discussion:
 *    Invoked when location updates are automatically resumed.
 *
 *    In the event that your application is terminated while suspended, you will
 *	  not receive this notification.
 */
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    
    VWW_LOG_DEBUG(@"");
}

/*
 *  locationManager:didFinishDeferredUpdatesWithError:
 *
 *  Discussion:
 *    Invoked when deferred updates will no longer be delivered. Stopping
 *    location, disallowing deferred updates, and meeting a specified criterion
 *    are all possible reasons for finishing deferred updates.
 *
 *    An error will be returned if deferred updates end before the specified
 *    criteria are met (see CLError).
 */
- (void)locationManager:(CLLocationManager *)manager
didFinishDeferredUpdatesWithError:(NSError *)error {
    
    VWW_LOG_DEBUG(@"");
}





@end
