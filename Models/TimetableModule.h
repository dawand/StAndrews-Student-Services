//
//  TimetableModule.h
//  Modules
//
//  Created by Dawand Sulaiman on 10/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

/**
 This class is a Timetable module model which holds all the properties for a module object (VEVENT)
 */
@interface TimetableModule : Model <NSCoding>
{
    NSString *ModuleCode;
    NSString *ModuleTitle;
    NSDate *StartDate;
    NSDate *EndDate;
    NSString *Location;
}

@property (nonatomic,strong) NSString *ModuleCode;
@property (nonatomic,strong) NSString *ModuleTitle;
@property (nonatomic,strong) NSDate *StartDate;
@property (nonatomic,strong) NSDate *EndDate;
@property (nonatomic,strong) NSString *Location;

@end
