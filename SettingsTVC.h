//
//  SettingsTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 04/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KeychainItemWrapper.h"

@interface SettingsTVC : UITableViewController

@property (nonatomic, strong) NSMutableArray *settings;
@property(nonatomic) Boolean username;
@property(nonatomic) Boolean password;
- (IBAction)saveBtnTapped:(id)sender;

@end
