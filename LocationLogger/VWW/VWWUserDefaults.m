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
+(void)addCoordinate:(NSDictionary*)coordinateDictionary{
    NSMutableArray *coordinateDictionaries = [[[NSUserDefaults standardUserDefaults]objectForKey:VWWUserDefaultCoordinates]mutableCopy];
    if(coordinateDictionaries == nil){
        coordinateDictionaries = [@[]mutableCopy];
    }
    [coordinateDictionaries insertObject:coordinateDictionary atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:coordinateDictionaries] forKey:VWWUserDefaultCoordinates];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSArray*)coordinates{
    NSArray *coordinateDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultCoordinates];
    if(coordinateDictionaries == nil){
        coordinateDictionaries = [@[]mutableCopy];
    }
    return coordinateDictionaries;
}
+(void)clearCoordinates{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:VWWUserDefaultCoordinates];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



static NSString *VWWUserDefaultLaunchOptionsKey = @"VWWUserDefaultLaunchOptionsKey";
+(void)addLaunchOptions:(NSDictionary*)launchParameter{
    NSMutableArray *launchOptionsDictionaries = [[[NSUserDefaults standardUserDefaults]objectForKey:VWWUserDefaultLaunchOptionsKey]mutableCopy];
    if(launchOptionsDictionaries == nil){
        launchOptionsDictionaries = [@[]mutableCopy];
    }
    [launchOptionsDictionaries insertObject:launchParameter atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:launchOptionsDictionaries] forKey:VWWUserDefaultLaunchOptionsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSArray*)launchOptions{
    NSArray *launchOptionsDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultLaunchOptionsKey];
    return launchOptionsDictionaries;
}

+(void)clearLaunchOptions{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:VWWUserDefaultLaunchOptionsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
