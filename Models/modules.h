//
//  modules.h
//
//  Created by Dawand Sulaiman on 16/06/2012.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import "coursework.h"
/**
 This class is a module model which holds all the properties for a module object
 */
@interface modules : Model <NSCoding>
{
    NSString *module_id;
    NSString *ayr_code;
    NSString *semester;
    NSString *module_code;
    NSString *title;
    NSMutableArray *courseworkArray;
}

@property (nonatomic, strong) NSString *module_id;
@property (nonatomic, strong) NSString *ayr_code;
@property (nonatomic, strong) NSString *semester;
@property (nonatomic, strong) NSString *module_code;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *courseworkArray;

@end
