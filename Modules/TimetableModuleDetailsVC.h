//
//  TimetableModuleDetailsVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 13/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimetableModule.h"
#import "LocationMapVC.h"

@interface TimetableModuleDetailsVC : UIViewController

@property (nonatomic,strong) TimetableModule *tm;
@property (weak, nonatomic) IBOutlet UILabel *ModuleTitle;
@property (weak, nonatomic) IBOutlet UILabel *ModuleCode;
@property (weak, nonatomic) IBOutlet UILabel *Location;
@property (weak, nonatomic) IBOutlet UILabel *DateStart;
@property (weak, nonatomic) IBOutlet UILabel *DateEnd;
- (IBAction)showLocationMap:(id)sender;

@end
