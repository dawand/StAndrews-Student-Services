//
//  TimetableModuleDetailsVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 13/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "TimetableModuleDetailsVC.h"

@implementation TimetableModuleDetailsVC
@synthesize remindMeBtn;
@synthesize tm;
@synthesize ModuleTitle;
@synthesize ModuleCode;
@synthesize Location;
@synthesize DateStart;
@synthesize DateEnd,selectedDate;

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
    //    NSLog([[[UIApplication sharedApplication] scheduledLocalNotifications] description]);
    
    if(tm.ModuleTitle != nil ){
        ModuleTitle.text = tm.ModuleTitle;
    }else{
        ModuleTitle.text = @"Module Title not available";
    }
    
    ModuleCode.text = tm.ModuleCode;
    Location.text = tm.Location;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat: @"HH:mm"]; 
    
    DateStart.text =[dateFormat stringFromDate:tm.StartDate];
    
    DateEnd.text =[dateFormat stringFromDate:tm.EndDate];
    
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
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:tm.ModuleCode]];
        if ([uid isEqualToString:tm.ModuleCode])
        {
            [remindMeBtn setImage:[UIImage imageNamed:@"clockCrossed.png"] forState:UIControlStateNormal]; 
            break;
        }
    }
    
    [super viewDidAppear:animated];
}


- (IBAction)showLocationMap:(id)sender {
    
    LocationMapVC *map = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationMapVC"];
    
    //to pass JH or JC
    [map setLocation:[tm.Location substringToIndex:2]];
    
    [self.navigationController pushViewController:map animated:YES];
    
}

- (IBAction)scheduleNotification:(id)sender {
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    if([sender currentImage] == [UIImage imageNamed:@"clock.png"]){
        
        //        NSLog([NSString stringWithFormat:@"%@",tm.StartDate]);
        
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        
        // Break the date up into components
        NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                                       fromDate:tm.StartDate];
        
        NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
                                                       fromDate:tm.StartDate];
        // Set up the fire time
        
        NSDateComponents *dateComps = [[NSDateComponents alloc] init];
        [dateComps setDay:[dateComponents day]];
        [dateComps setMonth:[dateComponents month]];
        [dateComps setYear:[dateComponents year]];
        [dateComps setHour:[timeComponents hour]];
        // Notification will fire in one minute
        [dateComps setMinute:[timeComponents minute] - 10];
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
            
            if (localNotif == nil)
                return;
            
            localNotif.fireDate = itemDate;
            localNotif.timeZone = [NSTimeZone defaultTimeZone];
            
            localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ in %i minutes.", nil),
                                    tm.ModuleCode, 10];
            localNotif.alertAction = NSLocalizedString(@"View Details", nil);
            
            localNotif.soundName = UILocalNotificationDefaultSoundName;
            localNotif.applicationIconBadgeNumber = 1;
            
            NSDictionary *infoDict = [NSDictionary dictionaryWithObject:tm.ModuleCode forKey:tm.ModuleCode];
            
            localNotif.userInfo = infoDict;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            [formatter setDateFormat:@"HH:mm dd-MM-yyyy"];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reminder is set successfully" message:[NSString stringWithFormat:@"You will be notified at %@",[formatter stringFromDate:localNotif.fireDate]] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            
            [alert show];
            
            [sender setImage:[UIImage imageNamed:@"clockCrossed.png"] forState:UIControlStateNormal]; 
            
        }
        
        else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"An unknown error occured!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
    else if([sender currentImage] == [UIImage imageNamed:@"clockCrossed.png"]){
        
        [[UIApplication sharedApplication] cancelLocalNotification:localNotif];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reminder Cancelled" message:[NSString stringWithFormat:@"The reminder for %@ is cancelled!",tm.ModuleCode] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        
        [sender setImage:[UIImage imageNamed:@"clock.png"] forState:UIControlStateNormal]; 
    }
    
    else{
        
        NSLog(@"error");
    }
    
    
}

- (IBAction)anotherNotifier:(id)sender {
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSDate *d = [NSDate date];
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )fromDate:d];
    
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )fromDate:d];
    // Set up the fire time
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
	// Notification will fire in one minute
    [dateComps setMinute:[timeComponents minute] +1];
	[dateComps setSecond:[timeComponents second]];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotif.alertBody = [NSString stringWithFormat:NSLocalizedString(@"%@ in %i minutes.", nil),
                            tm.ModuleCode, 1];
    localNotif.alertAction = NSLocalizedString(@"View Details", nil);
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:tm.ModuleCode forKey:tm.ModuleCode];
    localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"HH:mm dd-MM-yyyy"];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Reminder is set successfully" message:[NSString stringWithFormat:@"You will be notified at %@",[formatter stringFromDate:localNotif.fireDate]] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    [alert show];
}


- (void)viewDidUnload
{
    [self setModuleTitle:nil];
    [self setModuleCode:nil];
    [self setLocation:nil];
    [self setDateStart:nil];
    [self setDateEnd:nil];
    [self setRemindMeBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
