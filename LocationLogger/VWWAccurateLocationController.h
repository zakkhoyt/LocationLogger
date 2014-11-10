//
//  VWWAccurateLocationController.h
//  LocationLogger
//
//  Created by Zakk Hoyt on 11/10/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

static NSString *VWWAccurateLocationControllerNewLocationKey = @"newAccurateLocation";

@interface VWWAccurateLocationController : NSObject
+(VWWAccurateLocationController*)sharedInstance;
-(void)start;
-(void)stop;
-(void)reset;
// The latest location (check the error property for significance)
-(CLLocation*)lastLocation;

@end
