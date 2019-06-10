//
//  TimetableModule.m
//  Modules
//
//  Created by Dawand Sulaiman on 10/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "TimetableModule.h"

@implementation TimetableModule

@synthesize ModuleCode,ModuleTitle,StartDate,EndDate,Location;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
//    if([key isEqualToString:@"id"])
//        self.module_id = value;
//    
//    else [super setValue:value forUndefinedKey:key];
}


-(void) setValue:(id)value forKey:(NSString *)key
{

        [super setValue:value forKey:key];
}

//=========================================================== 
//  Keyed Archiving
//
//=========================================================== 
- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.ModuleCode forKey:@"module_code"];
    [encoder encodeObject:self.ModuleTitle forKey:@"title"];
    [encoder encodeObject:self.StartDate forKey:@"StartDate"];
    [encoder encodeObject:self.EndDate forKey:@"EndDate"];
    [encoder encodeObject:self.Location forKey:@"Location"];
    
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if ((self = [super init])) {
        if ([decoder containsValueForKey:@"module_code"])
            self.ModuleCode = [decoder decodeObjectForKey:@"module_code"];
        if ([decoder containsValueForKey:@"title"])
            self.ModuleTitle = [decoder decodeObjectForKey:@"title"];
        if ([decoder containsValueForKey:@"StartDate"])
            self.StartDate = [decoder decodeObjectForKey:@"StartDate"];
        if ([decoder containsValueForKey:@"EndDate"])
            self.EndDate = [decoder decodeObjectForKey:@"EndDate"];
        if ([decoder containsValueForKey:@"Location"])
            self.Location = [decoder decodeObjectForKey:@"Location"];
    }
    return self;
}


@end
