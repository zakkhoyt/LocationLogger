//
//  VWWUserDefaults.m
//  Synthesizer
//
//  Created by Zakk Hoyt on 2/17/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWUserDefaults.h"


@implementation VWWUserDefaults



static NSString *VWWUserDefaultCoordinates = @"VWWUserDefaultCoordinates";

// Get current array (check for nil), add, then write back.
+(void)addCoordinate:(NSDictionary*)coordinateDictionary{
    NSMutableArray *dictionaries = [[[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultCoordinates]mutableCopy];
    if(dictionaries == nil){
        dictionaries = [@[]mutableCopy];
    }
    [dictionaries insertObject:coordinateDictionary atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:dictionaries forKey:VWWUserDefaultCoordinates];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// Return array (check for nil)
+(NSArray*)coordinates{
    NSMutableArray *dictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultCoordinates];
    if(dictionaries == nil){
        dictionaries = [@[]mutableCopy];
    }
    return dictionaries;
}

// Remove array
+(void)clearCoordinates{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:VWWUserDefaultCoordinates];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



static NSString *VWWUserDefaultLaunchOptionsKey = @"VWWUserDefaultLaunchOptionsKey";
+(void)addLaunchOptions:(NSDictionary*)launchParameter{
    NSMutableArray *dictionaries = [[[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultLaunchOptionsKey]mutableCopy];
    if(dictionaries == nil){
        dictionaries = [@[]mutableCopy];
    }
    [dictionaries insertObject:launchParameter atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:dictionaries forKey:VWWUserDefaultLaunchOptionsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSArray*)launchOptions{
    NSMutableArray *dictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultLaunchOptionsKey];
    if(dictionaries == nil){
        dictionaries = [@[]mutableCopy];
    }
    return dictionaries;
}

+(void)clearLaunchOptions{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:VWWUserDefaultLaunchOptionsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


static NSString *VWWUserDefaultLocalNotificationsKey = @"localNotifications";
+(void)setLocalNotifications:(BOOL)on{
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:VWWUserDefaultLocalNotificationsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)localNotifications{
    return [[NSUserDefaults standardUserDefaults] boolForKey:VWWUserDefaultLocalNotificationsKey];
}

@end
