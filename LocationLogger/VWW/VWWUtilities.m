//
//  VWWUtilities.m
//  RC Video
//
//  Created by Zakk Hoyt on 3/10/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWUtilities.h"
#import <CoreLocation/CoreLocation.h>
#import "VWWDefines.h"

const float kFeetInAMeter = 3.28084;
//NSString *dateFormatString = @"MMMM dd, YYYY";
NSString *dateAndTimeFormatString = @"yyyy-MM-dd HH:mm:ss";

@implementation VWWUtilities

@end

@implementation  VWWUtilities (DateFormatter)
//
//+(NSDate*)dateFromString:(NSString*)string{
//    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
//    [dateLocal setDateFormat:dateFormatString];
//    return [dateLocal dateFromString:string];
//    
//}
+(NSDate*)dateAndTimeFromString:(NSString*)string{
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateLocal setDateFormat:dateAndTimeFormatString];
    NSDate *date = [dateLocal dateFromString:string];
    return date;
}

//+(NSString*)stringFromDate:(NSDate*)date{
//    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
//    [dateLocal setDateFormat:dateFormatString];
//    NSString* dateString = [dateLocal stringFromDate:date];
//    if(dateString == nil) dateString = @"";
//    return dateString;
//}

+(NSString*)stringFromDateAndTime:(NSDate*)date{
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
//    [dateLocal setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateLocal setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateLocal setDateFormat:dateAndTimeFormatString];
    NSString* dateString = [dateLocal stringFromDate:date];
    return dateString;
}
@end

@implementation VWWUtilities (Conversion)
+(float)metersToFeet:(float)meters{
    return meters * kFeetInAMeter;
}
+(float)metersBetweenPointA:(CLLocation*)pointA pointB:(CLLocation*)pointB{
    CLLocationDistance distance = [pointA distanceFromLocation:pointB];
    return fabs((float)distance);
}
+(float)feetBetweenPointA:(CLLocation*)pointA pointB:(CLLocation*)pointB{
    CLLocationDistance distance = [self metersBetweenPointA:pointA pointB:pointB];
    return ((float)(distance) * kFeetInAMeter);
}




+(NSString*)jsonRepresentationOfDictionary:(NSDictionary*)dictionary prettyPrint:(BOOL)prettyPrint{
    if([NSJSONSerialization isValidJSONObject:dictionary] == NO){
        VWW_LOG_WARNING(@"Cannot convert object to json");
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        VWW_LOG_ERROR(@"%@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}


+(NSString*)jsonRepresentationOfArray:(NSArray*)array prettyPrint:(BOOL)prettyPrint{
    if([NSJSONSerialization isValidJSONObject:array] == NO){
        VWW_LOG_WARNING(@"Cannot convert object to json");
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        VWW_LOG_ERROR(@"%@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}


// TODO: Convert this code so that it iterates recursively though all values and removed anythign class types that not allowed (NSData for example)
+(NSString*)jsonStringFromDictionary:(NSDictionary*)dictionary prettyPrint:(BOOL)prettyPrint{
    NSMutableDictionary *mutableDictionary = [dictionary mutableCopy];
    
    if([NSJSONSerialization isValidJSONObject:mutableDictionary] == NO){
        VWW_LOG_WARNING(@"Cannot convert object to json");
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mutableDictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData) {
        VWW_LOG_ERROR(@"%@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+(NSString*)jsonStringFromArray:(NSArray*)array prettyPrint:(BOOL)prettyPrint{
    
    if([NSJSONSerialization isValidJSONObject:array] == NO){
        VWW_LOG_WARNING(@"Cannot convert object to json");
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData) {
        VWW_LOG_ERROR(@"%@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}




@end
