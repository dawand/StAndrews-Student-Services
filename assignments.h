//
//  assignments.h
//
//  Created by Dawand Sulaiman on 16/06/2012.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface assignments : Model <NSCoding>

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

@end
