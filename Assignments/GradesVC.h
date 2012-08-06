//
//  GradesVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 21/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModulesCache.h"

/**
 Grades View Controller
 
 This class handles the view of the options for grades (all grades or overall average) and showing empty view if there is no data about modules in the device cache directory
 */
@interface GradesVC : UIViewController
{
    NSMutableArray *cachedModules;
}

@property (weak, nonatomic) IBOutlet UIView *CacheEmptyView;
@property (nonatomic,strong) NSMutableArray *cachedModules;

@end
