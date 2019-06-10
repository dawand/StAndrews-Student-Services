//
//  LoginVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 17/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MainTVC.h"
#import "AuthenticationEngine.h"
#import "ModulesTVC.h"
#import "TKAlertCenter.h"
#import "KeychainItemWrapper.h"

/**
 Login View Controller
 
 This class handles the authentication of the student. It conforms to AuthenticationEngineDelegate protocol
 */

@interface LoginVC : UIViewController<AuthenticationEngineDelegate>

@property (nonatomic, strong) RESTRequest *ModulesRequest; 
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;

/**
 This method hides keyboard when the username textfield is tapped
 */
- (IBAction)usernameTFTapped:(id)sender;
/**
 This method hides keyboard when the password textfield is tapped
 */
- (IBAction)passwordTFTapped:(id)sender;
/**
 This method launches feedback form from testflight feedback API
 */
- (IBAction)LaunchFeedback;
/**
 This method processes the inputs of textfield inputs and passes them to the methods in AuthenticationEngine Class
 */
 - (IBAction)loginBtnTapped:(id)sender;

@end
