//
//  UniversityNewsModel.h
//  Modules
//
//  Created by Dawand Sulaiman on 18/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface UniversityNewsModel : Model <NSCoding>

@property (nonatomic, strong) NSMutableArray *NewsArray;

@end
