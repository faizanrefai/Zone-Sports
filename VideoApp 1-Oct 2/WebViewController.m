//
//  WebViewController.m
//  TestDemoApplication
//
//

#import "WebViewController.h"


@implementation WebViewController
@synthesize activityIndicator;
@synthesize strURL;

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

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [activityIndicator stopAnimating];
}

-(void)dismissViewControl
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle
- (IBAction)btnClick:(id)sender
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    strURL=[NSURL URLWithString:@"http://www.findyourzone.tv"];
    NSURLRequest *request = [[[NSURLRequest alloc] initWithURL:strURL] autorelease];
    [webView loadRequest:request];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [activityIndicator release];
    [super dealloc];
}
@end
