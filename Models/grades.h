//
//  grades.h
//  Modules
//
//  Created by Dawand Sulaiman on 21/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class is grades model which holds all the properties for a grades object
 */
@interface grades : NSObject
{
    NSString *module;
    NSString *grade;
    NSString *assignment;
    NSNumber *weight;
}

@property (nonatomic,strong) NSString *module;
@property (nonatomic,strong) NSString *grade;
@property (nonatomic,strong) NSString *assignment;
@property (nonatomic,strong) NSNumber *weight;

@end
