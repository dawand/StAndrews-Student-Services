//
//  secondTimetableVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 08/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "iCalendarEngine.h"
#import "CGICalendar.h"
#import "TKCalendarMonthView.h"

@interface secondTimetableVC : UIViewController<iCalendarEngineDelegate, TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource>
{
	TKCalendarMonthView *calendar;	

}
@property (retain) NSMutableArray *objects;
@property (nonatomic, retain) TKCalendarMonthView *calendar;
@property (nonatomic, retain) NSMutableArray *data;

@end
