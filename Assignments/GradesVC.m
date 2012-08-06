//
//  GradesVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 21/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "GradesVC.h"

@implementation GradesVC

@synthesize CacheEmptyView,cachedModules;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [CacheEmptyView setHidden:YES];
        
    cachedModules = [ModulesCache getCachedMenuItems];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setCacheEmptyView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) viewDidAppear:(BOOL)animated{


    if(cachedModules ==nil){
    
        [CacheEmptyView setHidden:NO];
    }

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
