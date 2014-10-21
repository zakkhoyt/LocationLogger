//
//  APM Logger
//
//  Created by Zakk Hoyt 2014
//  Copyright (c) 2014 Zakk Hoyt.
//


#ifndef Smile_iOS_SMBlocks_h
#define Smile_iOS_SMBlocks_h

@class VWWAP2DataController;
@class CLLocation;
@class VWWLogFileSummary;
@class VWWSession;

typedef void (^VWWA2PDataSetBlock)(VWWAP2DataController* dataSet);
typedef void (^VWWArrayBlock)(NSArray *array);
typedef void (^VWWBoolBlock)(BOOL success);
typedef void (^VWWCLLocationBlock)(CLLocation *location);
typedef void (^VWWDictionaryBlock)(NSDictionary *dictionary);
typedef void (^VWWEmptyBlock)();
typedef void (^VWWErrorBlock)(NSError *error);
typedef void (^VWWErrorStringBlock)(NSError *error, NSString *description);
typedef void (^VWWFloatBlock)(float f);
typedef void (^VWWJSONBlock)(id json);
typedef void (^VWWIntegerBlock)(NSInteger index);
typedef void (^VWWLogFileSummaryBlock)(VWWLogFileSummary *summary);
typedef void (^VWWMutableArrayBlock)(NSMutableArray *array);
typedef void (^VWWMutableDictionaryBlock)(NSMutableDictionary *dictionary);
typedef void (^VWWOrderedSetBlock)(NSOrderedSet *set);
typedef void (^VWWProgessBlock)(NSInteger totalBytesSent, NSInteger totalBytesExpectedToSend);
typedef void (^VWWSessionBlock)(VWWSession *session);
typedef void (^VWWSetBlock)(NSOrderedSet *set);
typedef void (^VWWStringBlock)(NSString *string);
typedef void (^VWWStringBoolBlock)(NSString *string, BOOL success);
typedef void (^VWWUIntegerBlock)(NSUInteger index);
typedef void (^VWWURLErrorBlock)(NSURL *url, NSError *error);
#endif
