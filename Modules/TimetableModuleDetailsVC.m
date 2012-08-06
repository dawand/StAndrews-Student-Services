//
//  TimetableModuleDetailsVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 13/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "TimetableModuleDetailsVC.h"

@implementation TimetableModuleDetailsVC
@synthesize tm;
@synthesize ModuleTitle;
@synthesize ModuleCode;
@synthesize Location;
@synthesize DateStart;
@synthesize DateEnd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{    
    if(![tm.ModuleTitle isEqualToString:@""]){
    ModuleTitle.text = tm.ModuleTitle;
    }else{
    ModuleTitle.text = @"Module Title not available";
    }
    
    ModuleCode.text = tm.ModuleCode;
    Location.text = tm.Location;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat: @"HH:mm"]; 
    
    DateStart.text =[dateFormat stringFromDate:tm.StartDate];

    DateEnd.text =[dateFormat stringFromDate:tm.EndDate];
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setModuleTitle:nil];
    [self setModuleCode:nil];
    [self setLocation:nil];
    [self setDateStart:nil];
    [self setDateEnd:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showLocationMap:(id)sender {
    
    LocationMapVC *map = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationMapVC"];
    
    map.location = [tm.Location substringToIndex:2];
    
    [self.navigationController pushViewController:map animated:YES];
    
}
@end
