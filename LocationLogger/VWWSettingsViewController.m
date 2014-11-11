//
//  VWWSettingsViewController.m
//  LocationLogger
//
//  Created by Zakk Hoyt on 10/22/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "VWWSettingsViewController.h"
#import "VWW.h"
@interface VWWSettingsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;

@end

@implementation VWWSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.notificationsSwitch.on = [VWWUserDefaults localNotifications];
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


- (IBAction)notificationsSwitchValueChanged:(UISwitch*)sender {
    [VWWUserDefaults setLocalNotifications:sender.on];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [VWWUserDefaults clearCoordinates];
    } else if(indexPath.row == 1){
        [VWWUserDefaults clearLaunchOptions];
    }
}



@end
