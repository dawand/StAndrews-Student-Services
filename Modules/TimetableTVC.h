//
//  ThirdTimetableTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 09/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapkuLibrary.h"
#import "iCalendarEngine.h"
#import "AppDelegate.h"
#import "TimetableModule.h"
#import "TimetableModuleDetailsVC.h"
#import "TKProgressAlertView.h"
#import "TimetableCache.h"
#import "KeychainItemWrapper.h"

@interface TimetableTVC :TKCalendarMonthTableViewController <iCalendarEngineDelegate>{
    NSMutableArray *dataArray; 
	NSMutableDictionary *dataDictionary;
}

//@property (retain) NSMutableArray *objects;

@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;
@property (retain,nonatomic) NSMutableDictionary *dataSelected;
@property (retain,nonatomic) NSMutableDictionary *titleDictionary;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) NSMutableArray *StartDateData;
@property (nonatomic, strong) RESTRequest *ModulesRequest;
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;
@property (nonatomic,strong) NSMutableArray *cachedItems;

- (void) fetchFromServer: (NSString *) username :(NSString *) password;

- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end;

- (IBAction)RefreshBtnTapped:(id)sender;

@end