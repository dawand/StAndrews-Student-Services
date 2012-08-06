//
//  assignments.m
//
//  Created by Dawand Sulaiman on 16/06/2012.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import "assignments.h"

@implementation assignments
@synthesize ass_id,title,url,ass_style,deadline,file_url,override,submitted,mark,raw_mark,marks_visible;

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
    if([key isEqualToString:@"id"])
        self.ass_id = value;
    
    else if ([key isEqualToString:@"style"])
        self.ass_style = value;
    
    else if([key isEqualToString:@"override_deadline"])
        self.override = value;
    
    else [super setValue:value forUndefinedKey:key];
}

//=========================================================== 
//  Keyed Archiving
//
//=========================================================== 
- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:self.ass_id forKey:@"id"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.ass_style forKey:@"style"];
    [encoder encodeObject:self.deadline forKey:@"deadline"];
    [encoder encodeObject:self.file_url forKey:@"file_url"];
    [encoder encodeObject:self.override forKey:@"override_deadline"];
    [encoder encodeObject:self.submitted forKey:@"submitted"];
    [encoder encodeObject:self.mark forKey:@"mark"];
    [encoder encodeObject:self.raw_mark forKey:@"raw_mark"];


}

- (id)initWithCoder:(NSCoder *)decoder 
{
    if ((self = [super init])) {
        if ([decoder containsValueForKey:@"id"])
            self.ass_id = [decoder decodeObjectForKey:@"id"];
        if ([decoder containsValueForKey:@"title"])
            self.title = [decoder decodeObjectForKey:@"title"];
        if ([decoder containsValueForKey:@"url"])
            self.url = [decoder decodeObjectForKey:@"url"];
        if ([decoder containsValueForKey:@"style"])
            self.ass_style = [decoder decodeObjectForKey:@"style"];
        if ([decoder containsValueForKey:@"deadline"])
            self.deadline = [decoder decodeObjectForKey:@"deadline"];
        if ([decoder containsValueForKey:@"file_url"])
            self.file_url = [decoder decodeObjectForKey:@"file_url"];
        if ([decoder containsValueForKey:@"override_deadline"])
            self.override = [decoder decodeObjectForKey:@"override_deadline"];
        if ([decoder containsValueForKey:@"submitted"])
            self.submitted = [decoder decodeObjectForKey:@"submitted"];
        if ([decoder containsValueForKey:@"mark"])
            self.mark = [decoder decodeObjectForKey:@"mark"];
        if ([decoder containsValueForKey:@"raw_mark"])
            self.raw_mark = [decoder decodeObjectForKey:@"raw_mark"];
    }
    return self;
}


- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setAss_id:[self.ass_id copy]];
    [theCopy setTitle:[self.title copy]];
    [theCopy setURL:[self.url copy]];
    [theCopy setAss_style:[self.ass_style copy]];
    [theCopy setDeadline:[self.deadline copy]];
    [theCopy setOverride:[self.override copy]];
    [theCopy setFile_url:[self.file_url copy]];
    [theCopy setSubmitted:[self.submitted copy]];

    return theCopy;
}


@end
