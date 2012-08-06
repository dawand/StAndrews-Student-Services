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

@interface AssignmentDetailsVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *ATitle;
@property (weak, nonatomic) IBOutlet UILabel *ADeadline;
@property (weak, nonatomic) IBOutlet UILabel *AStatus;
@property (weak, nonatomic) IBOutlet UIButton *WebURLOutlet;
- (IBAction)WebURLBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *AMark;

@property (strong,nonatomic) assignments *assignment;
@end
