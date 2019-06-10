//
//  ModuleWebVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 03/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TKAlertCenter.h"
#import "TKProgressAlertView.h"

/**
 Module Web View Controller Class
 
 This class takes the URL from the assignment Details View controller and passes it to a web view
 */
@interface ModuleWebVC : UIViewController<UIWebViewDelegate, AuthenticationEngineDelegate>

@property (nonatomic,strong) NSString *AURL;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;
@property (nonatomic,retain)TKProgressAlertView *AlertProgress;
@property (nonatomic, strong) RESTRequest *ModulesRequest;

/**
 This method handles the dismissal of itself when done button is pressed
 */
- (IBAction)DoneBtnTapped:(id)sender;

@end
