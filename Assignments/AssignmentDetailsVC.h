//
//  AssignmentDetailsVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 03/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "assignments.h"
#import "ModuleWebVC.h"

/**
 Assignment Details View Controller Class
 
 This class contains all the details for a selected assignment passed from AssignmentsTVC class
 
 */
@interface AssignmentDetailsVC : UIViewController
{
    assignments *assignment;
}

@property (strong,nonatomic) assignments *assignment;
@property (weak, nonatomic) IBOutlet UILabel *ATitle;
@property (weak, nonatomic) IBOutlet UILabel *ADeadline;
@property (weak, nonatomic) IBOutlet UILabel *AStatus;
@property (weak, nonatomic) IBOutlet UILabel *AMark;
@property (weak, nonatomic) IBOutlet UIButton *remindMeBtn;
@property (weak, nonatomic) IBOutlet UIButton *WebURLOutlet;

/**
 This method sets a reminder for the assignment deadline
 */
- (IBAction)remindMe:(id)sender;

/**
 This method handles the web view of the assignment
 */
- (IBAction)WebURLBtn:(id)sender;

@end
