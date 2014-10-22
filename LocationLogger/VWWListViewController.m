//
//  ViewController.m
//  LocationLogger
//
//  Created by Zakk Hoyt on 10/21/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWListViewController.h"
#import "VWW.h"
#import "VWWLocationController.h"

@interface VWWListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *coordinateDictionaries;
@end

@implementation VWWListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refershControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];

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



-(void)refershControlAction:(UIRefreshControl*)sender{
    [self reloadCoordinates];
    [sender endRefreshing];
}



-(void)reloadCoordinates{
    self.coordinateDictionaries = [VWWUserDefaults coordinates];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.coordinateDictionaries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *dictionary = self.coordinateDictionaries[indexPath.row];
    
    NSNumber *latitudeNumber = dictionary[@"latitude"];
    NSNumber *longitudeNumber = dictionary[@"longitude"];
    NSNumber *horizontalAccuracyNumber = dictionary[@"horizontalAccuracy"];
    NSNumber *verticalAccuracyNumber = dictionary[@"verticalAccuracy"];
    NSDate *date = dictionary[@"date"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%.4f, %.4f +/- %.1fh %.1fv",
                           latitudeNumber.floatValue,
                           longitudeNumber.floatValue,
                           horizontalAccuracyNumber.floatValue,
                           verticalAccuracyNumber.floatValue];
    cell.detailTextLabel.text = date.description;
    return cell;
}



@end
