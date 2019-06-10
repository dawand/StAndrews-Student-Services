
#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize AuthEngine;
@synthesize engine;
@synthesize CalendarEngine;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //this is used for testflight reports
//    [TestFlight takeOff:@"2553aec807f4ec72477fba2b0d4f9c46_MTE1MzQzMjAxMi0wNy0zMSAyMDozMjoyNC41NjUxNjA"];
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

   // [defaults setBool:NO forKey:@"loggedin"];
    [defaults setBool:YES forKey:@"guestlogin"];
        
    application.applicationIconBadgeNumber = 0;
    
    // Handle launching from a notification
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif) {
        NSLog(@"Recieved Notification while running %@",localNotif);
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
//    NSLog(@"Application entered background state.");
    // bgTask is instance variable
//    NSAssert(self->bgTask == UIBackgroundTaskInvalid, nil);
//    
//    bgTask = [application beginBackgroundTaskWithExpirationHandler: ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [application endBackgroundTask:self->bgTask];
//            self->bgTask = UIBackgroundTaskInvalid;
//        });
//    }];
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        while ([application backgroundTimeRemaining] > 1.0) {
//            NSString *friend = [self checkForIncomingChat];
//            if (friend) {
//                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//                if (localNotif) {
//                    localNotif.alertBody = [NSString stringWithFormat:
//                                            NSLocalizedString(@"%@ has a reminder for you.", nil), friend];
//                    localNotif.alertAction = NSLocalizedString(@"Show Reminder", nil);
//                    localNotif.soundName = @"alarmsound.caf";
//                    localNotif.applicationIconBadgeNumber = 1;
//                    [application presentLocalNotificationNow:localNotif];
//                    friend = nil;
//                    break;
//                }
//            }
//        }
//        [application endBackgroundTask:self->bgTask];
//        self->bgTask = UIBackgroundTaskInvalid;
//    });

}

//- (NSString *) checkForIncomingChat {
//    return @"Modules";
//}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];

    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    application.applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application
{

    [[NSUserDefaults standardUserDefaults] synchronize];

    // Saves changes in the application's managed object context before the application terminates.
    
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
        
    NSLog(@"Recieved Notification any time %@",notif);

    UIApplication.sharedApplication.applicationIconBadgeNumber--;

}

@end
