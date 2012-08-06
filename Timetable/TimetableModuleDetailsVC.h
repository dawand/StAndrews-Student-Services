//
//  TimetableModuleDetailsVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 13/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TimetableModule.h"
#import "LocationMapVC.h"

/**
 Time table Module Details View Controller
 
 This class takes the timetable module from TimetableTVC class and shows details about that particular module
 */
@interface TimetableModuleDetailsVC : UIViewController
{
    TimetableModule *tm;
    NSDate *selectedDate;
}
@property (nonatomic,retain) TimetableModule *tm;
@property (weak, nonatomic) IBOutlet UILabel *ModuleTitle;
@property (weak, nonatomic) IBOutlet UILabel *ModuleCode;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *DateStart;
@property (weak, nonatomic) IBOutlet UILabel *DateEnd;
@property (nonatomic,strong) NSDate *selectedDate;
@property (weak, nonatomic) IBOutlet UIButton *remindMeBtn;

/**
 This method sends the module location to the map view
 
 */
- (IBAction)showLocationMap:(id)sender;

/**
 This method handles scheduling notification for the module start date
 */
- (IBAction)scheduleNotification:(id)sender;

/**
 This method is just for testing purpose to set a one minute reminder
 */
- (IBAction)anotherNotifier:(id)sender;

@end
