//
//  AppDelegate.m
//  LocationLogger
//
//  Created by Zakk Hoyt on 10/21/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "AppDelegate.h"
#import "VWWLocationController.h"
#import "VWW.h"

#import "VWWUserDefaults.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // prompt for notifications
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    NSMutableDictionary *mutableLaunchOptions = [[NSMutableDictionary alloc]initWithDictionary:launchOptions];
    mutableLaunchOptions[@"launchDate"] = [NSDate date];
    
    
    if (launchOptions != nil){
        if([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]){
            VWW_LOG_DEBUG(@"App was launched because of location updates.");
            [self scheduleLocalNotificationWithMessage:@"App Not Running"];
        }
    }

    // Log launch options
    [VWWUserDefaults addLaunchOptions:mutableLaunchOptions];
    
    // Start location manager to receive the location
    [[VWWLocationController sharedInstance]start];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    VWW_LOG_TRACE;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    VWW_LOG_TRACE;
}

-(void)scheduleLocalNotificationWithMessage:(NSString*)message{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification) {
        NSDate *date = [[NSDate date] dateByAddingTimeInterval:10];
        localNotification.fireDate = date;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = [NSString stringWithFormat:@"Significant Location Change. %@", message];
        localNotification.hasAction = YES;
        localNotification.alertAction = @"OK";
        localNotification.applicationIconBadgeNumber = 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}



@end
