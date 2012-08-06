//
//  iCalendarEngine.m
//  Modules
//
//  Created by Dawand Sulaiman on 08/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "iCalendarEngine.h"

@implementation iCalendarEngine

@synthesize delegate = delegate_;
@synthesize networkQueue = networkQueue_;
@synthesize data , StartDateData;

- (RESTRequest*) prepareRequestForURLString:(NSString*) urlString
{
    RESTRequest *request = [RESTRequest requestWithURL:[NSURL URLWithString:urlString]];  
    
    return request;
}
#pragma mark -
#pragma mark Custom Methods

// Add your custom methods here
-(id) initWithLoginName:(NSString*) loginName password:(NSString*) password
{
    self.networkQueue = [ASINetworkQueue queue];
  // [self.networkQueue setMaxConcurrentOperationCount:6];
    [self.networkQueue setDelegate:self];
    [self.networkQueue go];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:TIMETABLE_LOGIN_URL]];
    
	[request setUsername:loginName];
	[request setPassword:password];	
    
    [request setDelegate:self];
    
	[request setDidFinishSelector:@selector(loginDone:)];
	[request setDidFailSelector:@selector(loginFailed:)];
	
	[self.networkQueue addOperation:request];
    
    return self;
}

- (void)loginDone:(ASIHTTPRequest *)request
{
	NSDictionary *responseDict = [[request responseString] mutableObjectFromJSONString];	
	if([self.delegate respondsToSelector:@selector(loginSucceeded)])
		[self.delegate performSelector:@selector(loginSucceeded)];
}

- (void)loginFailed:(ASIHTTPRequest *)request
{
	if([self.delegate respondsToSelector:@selector(loginFailedWithError:)])
		[self.delegate performSelector:@selector(loginFailedWithError:) withObject:[request error]];
}

-(RESTRequest*) fetchTimetableItems
{
    [self retain];
    RESTRequest *request = [self prepareRequestForURLString:TIMETABLE_ITEMS_URL];
    
    [request setDelegate:self];
	[request setDidFinishSelector:@selector(menuFetchDone:)];
	[request setDidFailSelector:@selector(menuFetchFailed:)];	
	
	[self.networkQueue addOperation:request];
    
    return request;
}

- (void)menuFetchDone:(RESTRequest *)request
{    
    NSString *response = [request responseString];	
    
    CGICalendar *ical = [[CGICalendar alloc] init];
    if ([ical parseWithString:response error:nil]) {
        
         data = [[NSMutableArray alloc]init];
         StartDateData = [[NSMutableArray alloc]init];
        
        for (CGICalendarObject *icalObj in [ical objects]) {
            for (CGICalendarComponent *icalComp in [icalObj components]) {
                
                TimetableModule *tm = [[TimetableModule alloc]init];
                tm.ModuleCode = [icalComp summary];
                tm.ModuleTitle = [icalComp notes];
                tm.StartDate = [icalComp dateTimeStart];
                tm.EndDate = [icalComp dateTimeEnd];
                tm.Location = [icalComp propertyValueForName:@"LOCATION"];
                
                //to check if it is VEVENT or VTIMEZONE
                NSString *icalCompType = [icalComp type];
                
                unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
                NSCalendar* calendar = [NSCalendar currentCalendar];
                [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                
                NSDateComponents* components = [calendar components:flags fromDate:[icalComp dateTimeStart]];
                //    NSLog(@"%@", components);
                
                NSDate* dateOnly = [calendar dateFromComponents:components];
                
                if((dateOnly != nil) && !([icalCompType isEqualToString:@"VTIMEZONE"])){
                    [StartDateData addObject:dateOnly];
                    [data addObject:tm];
                }
                
                //                for (CGICalendarProperty *icalProp in [icalComp properties]) {
                //                    NSString *icalPropName = [icalProp name];
                //                    NSString *icalPropValue = [icalProp value];
                //                    if([icalPropName isEqualToString:@"DTSTART"]){
                //                        NSLog(icalPropValue);
                //                    }
                //                     //         NSLog(icalPropName);
                //                     //         NSLog(icalPropValue);
                //                    for (CGICalendarParameter *icalParam in [icalProp parameters]) {
                //                        NSString *icalParamName = [icalProp name];
                //                        NSString *icalPropValue = [icalProp value];
                //                                      NSLog(icalPropName);
                //                                      NSLog(icalPropValue);
                //                    }
                //                }
                
            }
        }
    }      
        NSMutableArray *bothArrays = [[NSMutableArray alloc]init];
        [bothArrays addObject:StartDateData];
        [bothArrays addObject:data];
        
	if([self.delegate respondsToSelector:@selector(menuFetchSucceeded:)])
		[self.delegate performSelector:@selector(menuFetchSucceeded:) withObject:bothArrays];
    
}

- (void) menuFetchFailed:(RESTRequest *)request
{
	if([self.delegate respondsToSelector:@selector(menuFetchFailed:)])
		[self.delegate performSelector:@selector(menuFetchFailed:) withObject:[request error]];
}

@end
