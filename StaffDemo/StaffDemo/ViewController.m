//
//  ViewController.m
//  StaffDemo
//
//  Created by 罗树新 on 2018/12/24.
//  Copyright © 2018 罗树新. All rights reserved.
//

#import "ViewController.h"
#import "TableViewViewController.h"
#import "Staff.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    Staff.sharedInstance.enable = YES;
}

- (IBAction)showTableView:(id)sender {
    TableViewViewController *tabViewVC = [[TableViewViewController alloc] init];
    [self presentViewController:tabViewVC animated:YES completion:nil];
}

@end
