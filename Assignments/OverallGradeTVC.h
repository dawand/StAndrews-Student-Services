//
//  OverallGradeTVC.h
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
#import "CustomCellBackgroundView.h"

/**
 Table view controller of overall module averages
 
 This class lists an overall average grade for each module
 
 */
@interface OverallGradeTVC : UITableViewController
{
    NSMutableArray *cachedModules;
    
    NSMutableArray *modulesArray;
    NSMutableArray *gradesArray;
    NSDictionary *gradesAndModules;
    NSMutableArray *modulesOverallArray;
    NSArray *sortedArray;
}

@property (nonatomic,strong) NSMutableArray *cachedModules;
@property (nonatomic,strong) NSMutableArray *modulesArray;
@property (nonatomic,strong) NSMutableArray *gradesArray;
@property (nonatomic,strong) NSDictionary *gradesAndModules;
@property (nonatomic,strong) NSMutableArray *modulesOverallArray;
@property (nonatomic,strong) NSArray *sortedArray;

@end
