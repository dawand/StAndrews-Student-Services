//
//  coursework.h
//
//  Created by Dawand Sulaiman on 16/06/2012.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import "assignments.h"

/**
 This class is an coursework model which holds all the properties for an coursework object
 */
@interface coursework : Model <NSCoding>
{
    NSString *cw_id;
    NSString *title;
    NSString *url;
    NSMutableArray *assignmentsArray;
}
@property (nonatomic, strong) NSString *cw_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSMutableArray *assignmentsArray;

@end
