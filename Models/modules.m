//
//  modules.m
//
//  Created by Dawand Sulaiman on 16/06/2012.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import "modules.h"

@implementation modules
@synthesize module_id,ayr_code,semester,module_code,title,courseworkArray;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        courseworkArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
        self.module_id = value;

    else [super setValue:value forUndefinedKey:key];
}


-(void) setValue:(id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"coursework"])
    {
        for(NSMutableDictionary *courseworkArrayDict in value)
        {
            coursework *thisCW = [[coursework alloc] initWithDictionary:courseworkArrayDict];
            [self.courseworkArray addObject:thisCW];
        }
    }
       else
        [super setValue:value forKey:key];
}

//=========================================================== 
//  Keyed Archiving
//
//=========================================================== 
- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.module_id forKey:@"id"];
    [encoder encodeObject:self.module_code forKey:@"module_code"];
    [encoder encodeObject:self.ayr_code forKey:@"ayr_code"];
    [encoder encodeObject:self.semester forKey:@"semester"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.courseworkArray forKey:@"coursework"];

}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if ((self = [super init])) {
        if ([decoder containsValueForKey:@"id"])
            self.module_id = [decoder decodeObjectForKey:@"id"];
        if ([decoder containsValueForKey:@"title"])
            self.title = [decoder decodeObjectForKey:@"title"];
        if ([decoder containsValueForKey:@"module_code"])
            self.module_code = [decoder decodeObjectForKey:@"module_code"];
        if ([decoder containsValueForKey:@"ayr_code"])
            self.ayr_code = [decoder decodeObjectForKey:@"ayr_code"];
        if ([decoder containsValueForKey:@"semester"])
            self.semester = [decoder decodeObjectForKey:@"semester"];
        if ([decoder containsValueForKey:@"coursework"])
            self.courseworkArray = [decoder decodeObjectForKey:@"coursework"];

    }
    return self;
}


@end
