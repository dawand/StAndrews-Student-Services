//
//  RSSDetailsVC.m
//  Modules
//
//  Created by Dawand Sulaiman on 26/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import "RSSDetailsVC.h"

@implementation RSSDetailsVC
@synthesize webView;
@synthesize activityIndicator;
@synthesize item;

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
    [self.navigationController setToolbarHidden:YES];

   // [activityIndicator setHidden:YES];
    
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    NSURL* url = [NSURL URLWithString:[item objectForKey:@"link"]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [super viewDidLoad];
}

#pragma mark -
#pragma mark UIWebViewDelegate messages
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    activityIndicator.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    activityIndicator.hidden = YES;
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
