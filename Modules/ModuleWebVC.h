//
//  ModuleWebVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 03/07/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleWebVC : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong) NSString *AURL;
- (IBAction)DoneBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;
@end
