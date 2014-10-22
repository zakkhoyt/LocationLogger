//
//  VWWLaunchViewController.m
//  LocationLogger
//
//  Created by Zakk Hoyt on 10/21/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWLaunchViewController.h"
#import "VWW.h"

@interface VWWLaunchViewController ()
@property (nonatomic, strong) NSArray *launchDictionaries;
@end

@implementation VWWLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadLaunches];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self reloadLaunches];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)reloadLaunches{
    self.launchDictionaries = [VWWUserDefaults launchOptions];
    [self.tableView reloadData];
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.launchDictionaries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *dictionary = self.launchDictionaries[indexPath.row];
    NSDate *date = dictionary[@"launchDate"];
    cell.textLabel.text = date.description;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu keys", dictionary.allKeys.count];
    return cell;
}


#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dictionary = self.launchDictionaries[indexPath.row];
    NSString *message = dictionary.description;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Launch Params" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    }]];
    
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end
