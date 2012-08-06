//
//  AssignmentsTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 02/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coursework.h"
#import "assignments.h"
#import "AssignmentDetailsVC.h"

@interface AssignmentsTVC : UITableViewController

@property (nonatomic, strong) NSString *ModuleTitle;
@property (nonatomic, strong) NSMutableArray *courseworkArray;
@property (nonatomic, strong) NSMutableArray *assignmentsArray;

@end
