
#import "LoginVC.h"

@implementation LoginVC

@synthesize ActivityIndicator;
@synthesize usernameTF;
@synthesize passwordTF;
@synthesize ModulesRequest;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [ActivityIndicator setHidden:YES];

    [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if([defaults boolForKey:@"rememberusername"]){
        usernameTF.text = [defaults stringForKey:@"username"];
    }
        
    passwordTF.secureTextEntry=YES;
    passwordTF.text =@"Razgyan86";
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setUsernameTF:nil];
    [self setPasswordTF:nil];
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewDidAppear:(BOOL)animated{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults boolForKey:@"guestlogin"])
    [self dismissModalViewControllerAnimated:YES];

}

- (void) viewDidDisappear:(BOOL)animated{

        if(self.ModulesRequest)
            [self.ModulesRequest cancel];
        
        [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)loginBtnTapped:(id)sender {
    
    [passwordTF resignFirstResponder];
    
    [ActivityIndicator setHidden:NO];
    [ActivityIndicator startAnimating];
    
    ApplicationDelegate.AuthEngine = [[AuthenticationEngine alloc] initWithLoginName:usernameTF.text password:passwordTF.text];
    ApplicationDelegate.AuthEngine.delegate = self;
    
}

-(void) loginSucceeded
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:YES forKey:@"loggedin"];
    [defaults setBool:YES forKey:@"rememberusername"];
    [defaults setObject:usernameTF.text forKey:@"username"];
    [defaults synchronize];

    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"MyPass" accessGroup:nil];

    [keychainItem setObject: passwordTF.text forKey:(__bridge id)kSecValueData];
    [keychainItem setObject: usernameTF.text forKey:(__bridge id)kSecAttrAccount];

  //  [ApplicationDelegate setUsername:usernameTF.text];
  //  [ApplicationDelegate setPassword:passwordTF.text];
    
    [ActivityIndicator setHidden:YES];

    [self dismissModalViewControllerAnimated:YES];
}

-(void) loginFailedWithError:(NSError*) error
{
    [ActivityIndicator setHidden:YES];
    
  //  TKAlertCenter *alert = [[TKAlertCenter alloc]init];
  //  [alert postAlertWithMessage:[error localizedDescription]];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Authentication failed" message:@"Please check your username and password" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    [alert show];
}

- (IBAction)usernameTFTapped:(id)sender {
    [usernameTF resignFirstResponder];
}

- (IBAction)passwordTFTapped:(id)sender {
    [passwordTF resignFirstResponder];
    [self loginBtnTapped:nil];
}

- (IBAction)LaunchFeedback {
        [TestFlight openFeedbackView];
}
@end
