//
//  AssignmentDetailsVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 03/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "AssignmentDetailsVC.h"

@implementation AssignmentDetailsVC
@synthesize remindMeBtn;
@synthesize AMark;
@synthesize ATitle;
@synthesize ADeadline;
@synthesize AStatus;
@synthesize WebURLOutlet;
@synthesize assignment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.navigationItem.title = assignment.title;
    
    ATitle.text = assignment.title;
    AMark.text = assignment.mark;
    
    //    NSLog(assignment.deadline);
    
    //    NSDate *date = [NSDate dateWithICalendarString:assignment.deadline];
    //
    //    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    //    
    //    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
    //												   fromDate:date];
    //    
    //    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
    //												   fromDate:date];
    //    
    //     NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    //    [dateComps setDay:[dateComponents day]];
    //    [dateComps setMonth:[dateComponents month]];
    //    [dateComps setYear:[dateComponents year]];
    //    [dateComps setHour:[timeComponents hour]];
    //    [dateComps setMinute:[timeComponents minute]];
    ////	[dateComps setSecond:[timeComponents second]];
    //    
    //    NSDate *deadlineDate = [calendar dateFromComponents:dateComps];
    
    //   NSString *DeadlineDateStr = assignment.deadline;
    //   NSLog(assignment.deadline);
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    
    NSDate *date = [dateFormat dateFromString:assignment.deadline];  
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"EEEE dd-LLL-YYYY H:mm"];
    //  [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *DeadlineDateStr = [dateFormat stringFromDate:date]; 
    
    //   NSString *DeadlineDateStr = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
    //  NSLog(DeadlineDateStr);
    
    ADeadline.text = DeadlineDateStr;
    
    NSString *submittedDateStr = assignment.submitted;
    
    // Convert string to date object
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDate *date2 = [dateFormat dateFromString:submittedDateStr];  
    
    // Convert date object to desired output format
    [dateFormat2 setDateFormat:@"EEEE dd-LLL-YYYY H:mm"];
    submittedDateStr = [dateFormat2 stringFromDate:date2]; 
    NSString *submittedDate = submittedDateStr;
    
    if(assignment.submitted != nil)
        AStatus.text =[NSString stringWithFormat:@"Submitted on %@", submittedDate];
    else
        AStatus.text = @"Not submitted yet";
    
    [super viewDidLoad];
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:YES];
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:assignment.title]];
        if ([uid isEqualToString:assignment.title])
        {
            [remindMeBtn setTitle:@"Cancel Reminder" forState:UIControlStateNormal];
            
            break;
        }
    }
    
    [super viewDidAppear:animated];
    
}

- (void)viewDidUnload
{
    [self setATitle:nil];
    [self setADeadline:nil];
    [self setAStatus:nil];
    [self setWebURLOutlet:nil];
    [self setAMark:nil];
    [self setRemindMeBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)WebURLBtn:(id)sender {
    
    ModuleWebVC *MWVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ModuleWebVC"];
    MWVC.AURL = assignment.url;
    
    [self presentModalViewController:MWVC animated:YES];
    
}

- (IBAction)remindMe:(id)sender {
    
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    
    if([[sender currentTitle]isEqualToString:@"Remind Me"]){
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        NSDate *date = [formatter dateFromString:assignment.deadline];
        //    NSLog(assignment.deadline);
        //    NSLog([NSString stringWithFormat:@"%@", date]);
        
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        
        // Break the date up into components
        NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                                       fromDate:date];
        
        NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
                                                       fromDate:date];
        // Set up the fire time
        
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setDay:[dateComponents day]];
        [dateComps setMonth:[dateComponents month]];
        [dateComps setYear:[dateComponents year]];
        [dateComps setHour:[timeComponents hour]];
        // Notification will fire in one minute
        [dateComps setMinute:[timeComponents minute] - minutesBefore];
        [dateComps setSecond:[timeComponents second]];
        NSDate *itemDate = [calendar dateFromComponents:dateComps];
        
        NSDate *dateNow = [NSDate date];
        //    NSLog([NSString stringWithFormat:@"%@", dateNow]);
        //   NSLog([NSString stringWithFormat:@"%@", itemDate]);
        
        if([itemDate compare:dateNow] == NSOrderedAscending){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"You cannot set a reminder for an earlier date than now" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
        
        else if ([itemDate compare:dateNow]==NSOrderedDescending) {
            
            if (localNoti == nil)
                return;
            
            localNoti.fireDate = itemDate;
            localNoti.timeZone = [NSTimeZone defaultTimeZone];
            
            localNoti.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ in %i minutes.", nil),
                                   assignment.title, minutesBefore];
            localNoti.alertAction = NSLocalizedString(@"View Details", nil);
            
            localNoti.soundName = UILocalNotificationDefaultSoundName;
            localNoti.applicationIconBadgeNumber = 1;
            
            NSDictionary *infoDict = [NSDictionary dictionaryWithObject:assignment.title forKey:assignment.title];
            
            //  [infoDict setValue:assignment.title forKey:@"module"];
            
            localNoti.userInfo = infoDict;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
            
            [formatter setDateFormat:@"HH:mm dd-MM-yyyy"];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reminder is set successfully" message:[NSString stringWithFormat:@"You will be notified at %@",[formatter stringFromDate:localNoti.fireDate]] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            
            [alert show];
            
            [sender setTitle:@"Cancel Reminder" forState:UIControlStateNormal]; 
            
        }
        
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"An unknown error occured!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
    else if([[sender currentTitle]isEqualToString:@"Cancel Reminder"]){
       
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *eventArray = [app scheduledLocalNotifications];
        
        for (int i=0; i<[eventArray count]; i++)
        {
            UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
            NSDictionary *userInfoCurrent = oneEvent.userInfo;
            NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:assignment.title]];
            if ([uid isEqualToString:assignment.title])
            {
         //       [remindMeBtn setTitle:@"Cancel Reminder" forState:UIControlStateNormal];
                //Cancelling local notification
                         [app cancelLocalNotification:oneEvent];
                break;
            }
        }
        
        
     //   [[UIApplication sharedApplication] cancelLocalNotification:localNoti];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reminder Cancelled" message:[NSString stringWithFormat:@"The reminder for %@ is cancelled!",assignment.title] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
        [sender setTitle:@"Remind Me" forState:UIControlStateNormal];
    }
    
    else{
        
        NSLog(@"error");
    }
}



@end
