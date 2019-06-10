//
//  InfoTVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 28/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTCustomColoredAccessory.h"

/** Information Table View Controller
 
 This class includes all the sections for the information sections and guest login
 
 */
@interface InfoTVC : UITableViewController
{
    NSMutableIndexSet *expandedSections;

}

@end
