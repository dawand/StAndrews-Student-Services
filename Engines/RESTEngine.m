
#import "RESTEngine.h"

@implementation RESTEngine

@synthesize delegate = delegate_;
@synthesize networkQueue = networkQueue_;

- (RESTRequest*) prepareRequestForURLString:(NSString*) urlString
{
    RESTRequest *request = [RESTRequest requestWithURL:[NSURL URLWithString:urlString]];  
  
  return request;
}


#pragma mark -
#pragma mark Custom Methods

-(id) initWithLoginName:(NSString*) loginName password:(NSString*) password
{
    self.networkQueue = [ASINetworkQueue queue];
  //  [self.networkQueue setMaxConcurrentOperationCount:6];
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

- (void)loginDone:(ASIHTTPRequest *)request
{
//	NSDictionary *responseDict = [[request responseString] mutableObjectFromJSONString];	
  //  self.accessToken = [responseDict objectForKey:@"accessToken"];	
	if([self.delegate respondsToSelector:@selector(loginSucceeded)])
		[self.delegate performSelector:@selector(loginSucceeded)]; 
                            //withObject:self.accessToken];
}

- (void)loginFailed:(ASIHTTPRequest *)request
{
	if([self.delegate respondsToSelector:@selector(loginFailedWithError:)])
		[self.delegate performSelector:@selector(loginFailedWithError:) withObject:[request error]];
}

-(RESTRequest*) fetchModuleItems
{
    [self.networkQueue setShouldCancelAllRequestsOnFailure:NO];

    [self retain];
    RESTRequest *request = [self prepareRequestForURLString:MODULE_ITEMS_URL];
    
    [request setDelegate:self];
	[request setDidFinishSelector:@selector(moduleFetchDone:)];
	[request setDidFailSelector:@selector(menuFetchFailed:)];	
	
	[self.networkQueue addOperation:request];
    
    return request;
}

- (void)moduleFetchDone:(RESTRequest *)request
{
   // NSMutableArray *responseArray = [[request responseString] mutableObjectFromJSONString];	
    NSMutableArray *menuItems = [NSMutableArray array];

    NSDictionary *mockResponseDictionary = [[request responseString] mutableObjectFromJSONString];
    NSArray *menuItemsDictionaries = [mockResponseDictionary objectForKey:@"modules"];
        
    for(NSMutableDictionary *menuItemDict in menuItemsDictionaries)
        [menuItems addObject:[[modules alloc] initWithDictionary:menuItemDict]];
    
	if([self.delegate respondsToSelector:@selector(moduleFetchSucceeded:)])
		[self.delegate performSelector:@selector(moduleFetchSucceeded:) withObject:menuItems];
}

- (void) moduleFetchFailed:(RESTRequest *)request
{
	if([self.delegate respondsToSelector:@selector(moduleFetchFailed:)])
		[self.delegate performSelector:@selector(moduleFetchFailed:) withObject:[request error]];
}

@end
