//
//  RootViewController.m
//  VideoApp
//
//  Created by  on 20/06/12.
//  Copyright 2012 . All rights reserved.
//

#import "RootViewController.h"
#import "JSONParser.h"
#import "WSStatic.h"
#import "WebViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appDelegate = (VideoAppAppDelegate*)[[UIApplication sharedApplication]delegate];
    aboutusView.backgroundColor=[UIColor clearColor];
    aboutusView.opaque=NO;
    [aboutusView setDataDetectorTypes:UIDataDetectorTypeLink];
    NSString *html= [NSString stringWithFormat:@"<html><head><title></title><style>body{background-color:transparent;text-align:justify;word-wrap:break-word;color:#555555;font-size:15px;font-family: Arial;}a { color:blue; }</style></head><body><a href=\"http://www.findyourzone.tv\">findyourzone.tv</a></body></html>"];
    aboutusView.delegate=self;
    aboutusView.scalesPageToFit= NO;
    
    [aboutusView loadHTMLString:html baseURL:[NSURL URLWithString:@""]];
 //   emailTxt.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"uname"];
//  passwoirdTxt.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"pass"];
    
}
- (IBAction)btnClick:(id)sender
{
    web = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    
    [self.navigationController pushViewController:web animated:YES];
   
}
- (IBAction)btnClick1:(id)sender
{
    web = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
   
    [self.navigationController pushViewController:web animated:YES];
    }

-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
   // NSURL* url = [request URL];
//    if (UIWebViewNavigationTypeLinkClicked == navigationType)
//    {
//        [[UIApplication sharedApplication] openURL:url];
//        
//    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}



// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return  YES;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)viewDidUnload
{
    [emailTxt release];
    emailTxt = nil;
    [passwoirdTxt release];
    passwoirdTxt = nil;
    [indicator release];
    indicator = nil;
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [emailTxt release];
    [passwoirdTxt release];
    [indicator release];
    [super dealloc];
}

-(IBAction)urllink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.findyourzone.tv"]];
}
-(void)parsingFinixh:(NSDictionary*)dic
{
    NSLog(@"%@",dic);
    
    
    if ([[dic valueForKey:@"msg"] isEqualToString:@"Login Successfully"]) {
       
        
        [[NSUserDefaults standardUserDefaults]setValue:[dic valueForKey:@"userid"] forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [indicator stopAnimating];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:appDelegate.navigationController.view cache:NO];
        [self.navigationController pushViewController:appDelegate.tabbarController animated:NO];
        [UIView commitAnimations];
        
    }else{
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Incorrect Email Or Password." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
        [indicator stopAnimating];

    }
    
    
    

}

- (IBAction)loginPressed:(id)sender {
    
    
    
    
    if ([emailTxt.text length]&&[passwoirdTxt.text length]) {
        
        [indicator startAnimating];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@?action=login&email=%@&password=%@",allVideolist,emailTxt.text,passwoirdTxt.text];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
        
        JSONParser *parser  = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsingFinixh:) andHandler:self];
        NSLog(@"%@",parser);
        

        
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter Emil and Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
    
    
    
     
     
}
@end
