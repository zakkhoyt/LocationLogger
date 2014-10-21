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
    NSMutableArray *launchOptionsDictionaries = [[[NSUserDefaults standardUserDefaults]objectForKey:VWWUserDefaultCoordinates]mutableCopy];
    if(launchOptionsDictionaries == nil){
        launchOptionsDictionaries = [@[]mutableCopy];
    }
    [launchOptionsDictionaries insertObject:coordinateDictionary atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:launchOptionsDictionaries] forKey:VWWUserDefaultCoordinates];
}
+(NSArray*)coordinates{
    NSArray *launchOptionsDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultCoordinates];
    return launchOptionsDictionaries;
}

static NSString *VWWUserDefaultLaunchOptionsKey = @"VWWUserDefaultLaunchOptionsKey";
+(void)addLaunchOptions:(NSDictionary*)launchParameter{
    NSMutableArray *launchOptionsDictionaries = [[[NSUserDefaults standardUserDefaults]objectForKey:VWWUserDefaultLaunchOptionsKey]mutableCopy];
    if(launchOptionsDictionaries == nil){
        launchOptionsDictionaries = [@[]mutableCopy];
    }
    [launchOptionsDictionaries insertObject:launchParameter atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithArray:launchOptionsDictionaries] forKey:VWWUserDefaultLaunchOptionsKey];
}

+(NSArray*)launchOptions{
    NSArray *launchOptionsDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:VWWUserDefaultLaunchOptionsKey];
    return launchOptionsDictionaries;
}

@end
