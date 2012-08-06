//
//  UniversityNewsModel.m
//  Modules
//
//  Created by Dawand Sulaiman on 18/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "UniversityNewsModel.h"

@implementation UniversityNewsModel
@synthesize NewsArray;

//=========================================================== 
//  Keyed Archiving
//
//=========================================================== 
- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.NewsArray forKey:@"NewsArray"];
    
}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if ((self = [super init])) {
    
        if ([decoder containsValueForKey:@"NewsArray"])
            self.NewsArray = [decoder decodeObjectForKey:@"NewsArray"];
        
    }
    return self;
}


@end
