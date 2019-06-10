
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
    
    if([passwordTF.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Empty password!" message:@"password cannot be empty. Please enter your password" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        
        [alert show];
    }
    
    else if([usernameTF.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Empty username!" message:@"username cannot be empty. Please enter your username" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        
        [alert show];
    }
    
    else{
    [passwordTF resignFirstResponder];
    
    [ActivityIndicator setHidden:NO];
    [ActivityIndicator startAnimating];
    
    ApplicationDelegate.AuthEngine = [[AuthenticationEngine alloc] initWithLoginName:usernameTF.text password:passwordTF.text];
    ApplicationDelegate.AuthEngine.delegate = self;
    
    }
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
    
    [ActivityIndicator setHidden:YES];

    [self dismissModalViewControllerAnimated:YES];
}

-(void) loginFailedWithError:(NSError*) error
{
    [ActivityIndicator setHidden:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                    message:[error localizedRecoverySuggestion]
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles: nil];    
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
