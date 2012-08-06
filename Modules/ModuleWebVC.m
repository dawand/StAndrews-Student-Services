//
//  ModuleWebVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 03/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "ModuleWebVC.h"

@implementation ModuleWebVC
@synthesize AURL;
@synthesize webView;
@synthesize ActivityIndicator;

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
    
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:AURL]]]; 
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    ActivityIndicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    ActivityIndicator.hidden = YES;
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)DoneBtnTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
