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
#import "TDBadgedCell.h"

/**
 Assignments Table View Controller Class
 
 This class holds the list of assignments for each module. It is called from ModulesTVC and it receives the module object and populates the list of assignments array into its table view
 */
@interface AssignmentsTVC : UITableViewController
{
    NSString *ModuleTitle;
    NSMutableArray *courseworkArray;
    NSMutableArray *assignmentsArray;
}

@property (nonatomic, strong) NSString *ModuleTitle;
@property (nonatomic, strong) NSMutableArray *courseworkArray;
@property (nonatomic, strong) NSMutableArray *assignmentsArray;

@end
