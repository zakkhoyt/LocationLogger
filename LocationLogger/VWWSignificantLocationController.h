//
//  VWWLocationController.h
//  VWWClusteredMapView
//
//  Created by Zakk Hoyt on 10/13/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

static NSString *VWWSignificantLocationControllerNewLocationKey = @"newLocation";

@interface VWWSignificantLocationController : NSObject
+(VWWSignificantLocationController*)sharedInstance;
-(void)start;
-(void)stop;
-(void)reset;
// The latest location (check the error property for significance)
-(CLLocation*)lastLocation;
@end
 