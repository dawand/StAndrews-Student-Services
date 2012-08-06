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
#import "KeychainItemWrapper.h"

@interface ModulesTVC : UITableViewController<RESTEngineDelegate>

- (void) splitToTwoSemesters: (NSMutableArray *)allYearModules;
- (void) fetchFromServer: (NSString *) username :(NSString *) password;
- (IBAction)ModuleSegChoiceTapped:(id)sender;
- (IBAction)RefreshBtnTapped:(id)sender;

@property(nonatomic,strong)NSMutableArray *Modules;
@property(nonatomic,strong)NSMutableArray *FirstSemModules;
@property(nonatomic,strong)NSMutableArray *SecondSemModules;
@property(nonatomic,strong)NSString *SelectedModuleCode;
@property (nonatomic, strong) NSMutableArray *courseworkArray;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ModuleSemSeg;
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;
@property (nonatomic, strong) RESTRequest *ModulesRequest;
@property (nonatomic,strong) NSMutableArray *cachedItems;

@end
