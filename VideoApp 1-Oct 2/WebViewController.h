//
//  WebViewController.h
//  TestDemoApplication
//
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;

}

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic, retain) NSURL *strURL;

-(IBAction)dismissViewControl;

@end
