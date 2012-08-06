//
//  ModulesTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 30/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "modules.h"
#import "RESTEngine.h"
#import "AssignmentsTVC.h"
#import "TKProgressAlertView.h"
#import "ModulesCache.h"
#import "TKAlertCenter.h"
#import "TDBadgedCell.h"

/**
 Modules and Assignment Table View Controller Class
 
 This class handles the retrieval of the list of modules. It conforms to RESTEngineDelegate protocol
 
 */
@interface ModulesTVC : UITableViewController<RESTEngineDelegate>
{
    NSMutableArray *Modules;
    NSMutableArray *FirstSemModules;
    NSMutableArray *SecondSemModules;
    NSString *SelectedModuleCode;
    NSMutableArray *courseworkArray;
    NSMutableArray *cachedItems;
    NSString *username;
    NSString *password;
    RESTRequest *ModulesRequest;
    TKProgressAlertView *AlertProgress;
    NSString *dateLabelStr;
}

/**
 This array holds the current retrieved modules from server
 */
@property(nonatomic,strong) NSMutableArray *Modules;
/**
 This array holds the modules for first semester
 */
@property(nonatomic,strong) NSMutableArray *FirstSemModules;
/**
 This array holds the modules for second semester

 */
@property(nonatomic,strong) NSMutableArray *SecondSemModules;

/**
 This holds the string of selected module to be passed to the assignments view controller
 */
@property(nonatomic,strong) NSString *SelectedModuleCode;

/**
 This is used for couting the coursework in each module for showing a badge next to the module indicating the number
 */
@property (nonatomic, strong) NSMutableArray *courseworkArray;

/**
 this outlet is a refrence for the segment control
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *ModuleSemSeg;

/**
 This is the tapku library alert progress shown while retrieving the modules from the server
 */
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;

/**
 This is the reference to the current request. It is used to be cancelled out if there is another request is running already
 */
@property (nonatomic, strong) RESTRequest *ModulesRequest;

/**
 this is the outlet for the bar button in the bottom for showing the date the last module fetching from server was performed
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dateLabel;

/**
 This array holds the cached modules in the cache directory
 */
@property (nonatomic,strong) NSMutableArray *cachedItems;

/**
 This is the password of the student used for sending it to server for authentication purposes
 */
@property (nonatomic,strong) NSString *password;

/**
 This is the username of the student used for sending it to server for authentication purposes
 */
@property (nonatomic,strong) NSString *username;

/**
 This string will be used to hold the string of the date label in the bottom
 */
@property (nonatomic,strong) NSString *dateLabelStr;

/**
 This method splits the modules into semester one and two based on their "semester" property from the retrieved JSON data
 @param the list of modules array
 */
- (void) splitToTwoSemesters: (NSMutableArray *)allYearModules;

/**
 This method performs the retrieval of the modules by calling the methods in the RESTEngine protocol
 */
- (void) fetchFromServer;

/**
 This method handles the changes when the segment control is tapped (All, Semester one, and Semester two) segments
 */
- (IBAction)ModuleSegChoiceTapped:(id)sender;

/**
 This method performs the retrieval of modules from the server again by calling the fetchFromServer method when Refresh button is pressed
 */
- (IBAction)RefreshBtnTapped:(id)sender;

/**
 This method checks for any changes and inconsistency between the current version of modules in the cache and the retrieved list of modules fetched from the server
 */
- (void) checkForChanges:(NSMutableArray *) LatestModulesArray;

@end
