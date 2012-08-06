
#import "AuthenticationEngine.h"

@implementation AuthenticationEngine

@synthesize delegate = delegate_;
@synthesize networkQueue = networkQueue_;


#pragma mark -
#pragma mark Custom Methods

-(id) initWithLoginName:(NSString*) loginName password:(NSString*) password
{
    self.networkQueue = [ASINetworkQueue queue];
    [self.networkQueue setMaxConcurrentOperationCount:6];
    [self.networkQueue setDelegate:self];
    [self.networkQueue go];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:LOGIN_URL]];
    
	[request setUsername:loginName];
	[request setPassword:password];	
    
    [request setDelegate:self];
    
	[request setDidFinishSelector:@selector(loginDone:)];
	[request setDidFailSelector:@selector(loginFailed:)];
	
	[self.networkQueue addOperation:request];
    
    return self;
}

//just using cookies instead of this for now

- (id) WebViewLogin:(NSString*) loginName password:(NSString*) password:(NSString*) WebURL{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:WebURL]];
    
    [request setUseKeychainPersistence:YES];
    [request setUseSessionPersistence:YES];
    [request setUseCookiePersistence:YES];
    
    [request setPostValue:loginName forKey:@"__ac_name"];
    [request setPostValue:password forKey:@"__ac_password"];
    [request setPostValue:@"1" forKey:@"form.submitted"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
    [request setDidFinishSelector:@selector(WebViewLoginDone:)];
	[request setDidFailSelector:@selector(loginFailed:)];
    
    return self;
}


- (void)WebViewLoginDone:(ASIHTTPRequest *)request
{
	if([self.delegate respondsToSelector:@selector(webViewLoginSucceeded:)])
		[self.delegate performSelector:@selector(webViewLoginSucceeded:) withObject:request];
}

- (void)loginDone:(ASIHTTPRequest *)request
{
	if([self.delegate respondsToSelector:@selector(loginSucceeded)])
		[self.delegate performSelector:@selector(loginSucceeded)]; 
}

- (void)loginFailed:(ASIHTTPRequest *)request
{
	if([self.delegate respondsToSelector:@selector(loginFailedWithError:)])
		[self.delegate performSelector:@selector(loginFailedWithError:) withObject:[request error]];
}

@end
