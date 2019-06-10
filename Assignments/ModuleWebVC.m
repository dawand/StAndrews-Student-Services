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
@synthesize ActivityIndicator, AlertProgress,ModulesRequest;

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    
       KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];
    
    NSString *password = [keychainItem objectForKey:(__bridge id) kSecValueData];
    NSString *username = [keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    
    ApplicationDelegate.AuthEngine = [[AuthenticationEngine alloc]WebViewLogin:username password:password:AURL];

    ApplicationDelegate.AuthEngine.delegate=self;
    
   [super viewDidLoad];

}

-(void) viewDidAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:NO];
    [super viewDidAppear:animated];
    
}
- (void)webViewLoginSucceeded:(ASIHTTPRequest *)request {
    
    NSError *error = [request error];
    if (!error) {
        
        [webView loadRequest:[NSURLRequest  requestWithURL:[request url]]];
        
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:@"username" forKey:NSHTTPCookieName];
     //   [cookieProperties setObject:ApplicationDelegate.username forKey:NSHTTPCookieValue];
        [cookieProperties setObject:AURL forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:AURL forKey:NSHTTPCookieOriginURL];
        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
        [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
        
        // set expiration to one month from now or any NSDate of your choosing
        // this makes the cookie sessionless and it will persist across web sessions and app launches
        /// if you want the cookie to be destroyed when your app exits, don't set this
        [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
        
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        
    }
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
    return YES;
}

- (IBAction)DoneBtnTapped:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
