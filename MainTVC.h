//
//  MainTVC.h
//  Student App
//
//  Created by Dawand Sulaiman on 25/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginVC.h"
#import "RSSLoaderTVC.h"
#import "ModulesTVC.h"
#import "TimetableTVC.h"
#import "SettingsTVC.h"
#import "UniRSSLoaderTVC.h"
#import "GradesVC.h"
#import "NotificationsTVC.h"
#import "LibraryVC.h"
#import "timetableListiPadTVC.h"
#import "InfoTVC.h"
#import "TDBadgedCell.h"

/**
 Main Table View Controller
 
 This class represents the main view and it is the first view to be loaded when the application launches
 
 */
@interface MainTVC : UITableViewController
{
    RESTRequest *ModulesRequest;
    NSMutableArray *sectionsAndRowsText;
    NSMutableArray *sectionsAndRowsDetailsText;
}

@property (nonatomic, strong) RESTRequest *ModulesRequest; 
@property (nonatomic, strong) NSMutableArray *sectionsAndRowsText;
@property (nonatomic, strong) NSMutableArray *sectionsAndRowsDetailsText;

- (IBAction)SettingsBtnTapped:(id)sender;

@end
