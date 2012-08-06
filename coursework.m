//
//  coursework.m
//
//  Created by Dawand Sulaiman on 16/06/2012.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import "coursework.h"

@implementation coursework
@synthesize cw_id,title,url,assignmentsArray;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        assignmentsArray = [[NSMutableArray alloc] init];

    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
        self.cw_id = value;
    
    else [super setValue:value forUndefinedKey:key];
}

-(void) setValue:(id)value forKey:(NSString *)key
{
    if([key isEqualToString:@"assignments"])
    {
        for(NSMutableDictionary *assignmentsArrayDict in value)
        {
            assignments *thisASS = [[assignments alloc] initWithDictionary:assignmentsArrayDict];
            [self.assignmentsArray addObject:thisASS];
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
    [encoder encodeObject:self.cw_id forKey:@"id"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.assignmentsArray forKey:@"assignments"];

}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if ((self = [super init])) {
        if ([decoder containsValueForKey:@"id"])
            self.cw_id = [decoder decodeObjectForKey:@"id"];
        if ([decoder containsValueForKey:@"title"])
            self.title = [decoder decodeObjectForKey:@"title"];
        if ([decoder containsValueForKey:@"url"])
            self.url = [decoder decodeObjectForKey:@"url"];
        if ([decoder containsValueForKey:@"assignments"])
            self.assignmentsArray = [decoder decodeObjectForKey:@"assignments"];
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setCw_id:[self.cw_id copy]];
    [theCopy setTitle:[self.title copy]];
    [theCopy setURL:[self.url copy]];
    
    return theCopy;
}

@end
