//
//  RootViewController.h
//  VideoApp
//
//  Created by  on 20/06/12.
//  Copyright 2012 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoAppAppDelegate.h"
#import "WebViewController.h"

@interface RootViewController : UIViewController<UITextFieldDelegate,UIWebViewDelegate> {
    
    IBOutlet UITextField *emailTxt;
    IBOutlet UITextField *passwoirdTxt;
    IBOutlet UIActivityIndicatorView *indicator;
    VideoAppAppDelegate *appDelegate;
    IBOutlet UIWebView *aboutusView;
    WebViewController *web;
    
}

- (IBAction)loginPressed:(id)sender;
- (IBAction)btnClick:(id)sender;
- (IBAction)btnClick1:(id)sender;
@end
