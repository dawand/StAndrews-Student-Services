//
//  Notification.h
//  Modules
//
//  Created by Dawand Sulaiman on 24/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class is a notification model which holds all the properties for a notification object
 */
@interface Notification : NSObject
{
    NSDate *fireDate;
    NSString *alertBody;
    NSDictionary *userinfo;
}

@property(nonatomic,strong) NSDate *fireDate;
@property (nonatomic,strong) NSString *alertBody;
@property (nonatomic,strong) NSDictionary *userinfo;

@end
