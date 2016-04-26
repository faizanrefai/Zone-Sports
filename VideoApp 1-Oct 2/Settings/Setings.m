//
//  Setings.m
//  VideoApp
//
//  Created by  on 20/06/12.
//  Copyright 2012 . All rights reserved.
//

#import "Setings.h"
#import "WebViewController.h"

@implementation Setings

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return  YES;
}

- (IBAction)btnClick:(id)sender
{
     self.navigationController.navigationBarHidden=YES;
   WebViewController* web = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    
    [self.navigationController pushViewController:web animated:YES];
    
}
- (void)dealloc
{
    [pickerManu release];
    [userName release];
    [pASSword release];
    [toolbar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     
    aboutusView.backgroundColor=[UIColor clearColor];
    aboutusView.opaque=NO;
   
    [aboutusView setDataDetectorTypes:UIDataDetectorTypeLink];
    NSString *html= [NSString stringWithFormat:@"<html><head><title></title><style>body{background-color:transparent;text-align:justify;word-wrap:break-word;color:#555555;font-size:14px;font-family: Arial;}a { color:blue; }</style></head><body><a href=\"http://www.findyourzone.tv\">findyourzone.tv</a></body></html>"];
    aboutusView.delegate=self;
    aboutusView.scalesPageToFit= NO;
    
    [aboutusView loadHTMLString:html baseURL:[NSURL URLWithString:@""]];

   userName.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"uname"];
  pASSword.text=  [[NSUserDefaults standardUserDefaults]valueForKey:@"pass"];

    
    self.title = @"Settings";

    // Do any additional setup after loading the view from its nib.
}
-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = [request URL];
    if (UIWebViewNavigationTypeLinkClicked == navigationType)
    {
        [[UIApplication sharedApplication] openURL:url];
        
    }
    return YES;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return 20;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 1;

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return @"Test Menu";

}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    //pickerManu.hidden=TRUE;
   // toolbar.hidden=TRUE;

}
- (void)viewDidUnload
{
    [pickerManu release];
    pickerManu = nil;
    [userName release];
    userName = nil;
    [pASSword release];
    pASSword = nil;
    [toolbar release];
    toolbar = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)mauPressed:(id)sender {
    
    pickerManu.hidden=FALSE;
    toolbar.hidden=FALSE;
}

- (IBAction)savePressed:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert show];
    [alert release];
    
    [[NSUserDefaults standardUserDefaults]setValue:userName.text forKey:@"uname"];
    [[NSUserDefaults standardUserDefaults]setValue:pASSword.text forKey:@"pass"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

- (IBAction)backPress:(id)sender {
    
    pickerManu.hidden=TRUE;
     toolbar.hidden=TRUE;
}
@end
