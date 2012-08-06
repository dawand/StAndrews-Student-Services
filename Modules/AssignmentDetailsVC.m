//
//  AssignmentDetailsVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 03/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "AssignmentDetailsVC.h"

@implementation AssignmentDetailsVC
@synthesize AMark;
@synthesize ATitle;
@synthesize ADeadline;
@synthesize AStatus;
@synthesize WebURLOutlet;
@synthesize assignment;

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
    [super viewDidLoad];
    self.navigationItem.title = assignment.title;
    
    ATitle.text = assignment.title;
    AMark.text = assignment.mark;
        
    NSString *DeadlineDateStr = assignment.deadline;

    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDate *date = [dateFormat dateFromString:DeadlineDateStr];  
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"EEEE dd-LLL-YYYY H:mm"];
    DeadlineDateStr = [dateFormat stringFromDate:date]; 
    ADeadline.text = DeadlineDateStr;

    
    NSString *submittedDateStr = assignment.submitted;
    
    // Convert string to date object
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    NSDate *date2 = [dateFormat dateFromString:submittedDateStr];  
    
    // Convert date object to desired output format
    [dateFormat2 setDateFormat:@"EEEE dd-LLL-YYYY H:mm"];
    submittedDateStr = [dateFormat2 stringFromDate:date2]; 
    NSString *submittedDate = submittedDateStr;
    
    if(assignment.submitted != nil)
    AStatus.text =[NSString stringWithFormat:@"Submitted on %@", submittedDate];
    else
    AStatus.text = @"Not submitted yet";
    
    WebURLOutlet.titleLabel.text = assignment.url;
}


- (void)viewDidUnload
{
    [self setATitle:nil];
    [self setADeadline:nil];
    [self setAStatus:nil];
    [self setWebURLOutlet:nil];
    [self setAMark:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)WebURLBtn:(id)sender {
    
    ModuleWebVC *MWVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ModuleWebVC"];
    MWVC.AURL = assignment.url;
    
    [self presentModalViewController:MWVC animated:YES];
    
}
@end
