//
//  assignments.h
//
//  Created by Dawand Sulaiman on 16/06/2012.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

/**
 This class is an assignment model which holds all the properties for an assignment object
 */
@interface assignments : Model <NSCoding>
{
    NSString *ass_id;
    NSString *title;
    NSString *ass_style;
    NSString *url;
    NSString *deadline;
    NSString *override;
    NSString *marks_visible;
    NSString *raw_mark;
    NSString *mark;
    NSString *file_url;
    NSString *submitted;
    NSNumber *weight;
}

@property (nonatomic, strong) NSString *ass_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *ass_style;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *deadline;
@property (nonatomic, strong) NSString *override;
@property (nonatomic, strong) NSString *marks_visible;
@property (nonatomic, strong) NSString *raw_mark;
@property (nonatomic, strong) NSString *mark;
@property (nonatomic, strong) NSString *file_url;
@property (nonatomic, strong) NSString *submitted;
@property (nonatomic, strong) NSNumber *weight;

@end
