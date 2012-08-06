//
//  TimetableModule.h
//  Modules
//
//  Created by Dawand Sulaiman on 10/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface TimetableModule : Model <NSCoding>

@property (nonatomic,strong) NSString *ModuleCode;
@property (nonatomic,strong) NSString *ModuleTitle;
@property (nonatomic,strong) NSDate *StartDate;
@property (nonatomic,strong) NSDate *EndDate;
@property (nonatomic,strong) NSString *Location;

@end
