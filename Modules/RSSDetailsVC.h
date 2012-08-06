//
//  RSSDetailsVC.h
//  Modules
//
//  Created by Dawand Sulaiman on 26/06/2012.
//  Copyright (c) 2012 University of St Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSDetailsVC : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (retain, nonatomic) NSDictionary* item;

@end
