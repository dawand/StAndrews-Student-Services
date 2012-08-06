//
//  AllGradesTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 21/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModulesCache.h"
#import "modules.h"
#import "coursework.h"
#import "assignments.h"
#import "grades.h"

/**
 Table view controller of all grades
 
 This class lists all the grades for all the modules
 
 */
@interface AllGradesTVC : UITableViewController
{
    NSMutableArray *cachedModules;
    NSMutableArray *modulesArray;
    NSMutableArray *gradesArray;
    NSDictionary *gradesAndModules;
    NSArray *sortedArray;
}

@property (nonatomic,strong) NSMutableArray *cachedModules;
@property (nonatomic,strong) NSMutableArray *modulesArray;
@property (nonatomic,strong) NSMutableArray *gradesArray;
@property (nonatomic,strong) NSDictionary *gradesAndModules;
@property (nonatomic,strong) NSArray *sortedArray;

/**
 This method handles sorting the list of grades in a descending order
 */
- (IBAction)SortTapped:(id)sender;

@end
