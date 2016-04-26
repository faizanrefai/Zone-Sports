//
//  VideoDetailView.m
//  VideoApp
//
//  Created by  on 21/06/12.
//  Copyright 2012 . All rights reserved.
//

#import "VideoDetailView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CMTime.h>
#import <CoreMedia/CMTimeRange.h>
#include <CoreMedia/CMBase.h>
#include <CoreFoundation/CoreFoundation.h>
#import "JSONParser.h"
#import "ADVPercentProgressBar.h"

#import <MediaPlayer/MediaPlayer.h>
#import "WSStatic.h"
#import <QuartzCore/QuartzCore.h>

double ij = 0;
@implementation VideoDetailView

@synthesize dictionary;

@synthesize onIphone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dictionary =[[NSMutableDictionary alloc]init ];
        
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [webing release];
    [description release];
    [nameTitle release];
    [createdDateTile release];
    [iphoneBtn release];
    [deletePressed release];
    [indicator release];
    [saveToIphone release];
    [inageVi release];
    [super dealloc];
    [dictionary release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    webing.delegate=self;
    NSLog(@"%@",dictionary);
    //VdoUrl
    
    description.text =     [dictionary valueForKey:@"description"];
    nameTitle.text = [NSString stringWithFormat:@"%@",      [dictionary valueForKey:@"name"]];
    createdDateTile.text =  [NSString stringWithFormat:@"%@",     [dictionary valueForKey:@"created_at"]];
    NSString *imgUrlStr = [[NSString stringWithFormat:@"%@",  [dictionary valueForKey:@"thumbUrl"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    inageVi.imageURL = [NSURL URLWithString:imgUrlStr];
    
    self.title=@"Video Detail";
    // Do any additional setup after loading the view from its nib.jing
   /// NSURL *str=[[NSBundle mainBundle] URLForResource:@"Movi" withExtension:@"mp4"];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backina)];
    self.navigationItem.leftBarButtonItem=btn;
    
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [documentPath objectAtIndex:0];
    
    NSString *newPlistFile  = [documentFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[dictionary valueForKey:@"vdo_id"]]];
    
    NSLog(@"%@",newPlistFile);
    [webing loadHTMLString:[self LoadHtmlString:[NSURL URLWithString:imgUrlStr]] baseURL:nil];
    [indicator startAnimating];


    
    if (onIphone) {
        btnPlay.hidden=FALSE;
        
    }else{
        btnPlay.hidden=TRUE;
       NSString *strUrl = [NSString stringWithFormat:@"%@?vdo_id=%@",videoPlay,[dictionary valueForKey:@"vdo_id"]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
        [webing loadRequest:request];
    }
}

-(void)backina{    if(moviePlayer)
{
    [moviePlayer pause];
    [moviePlayer.view removeFromSuperview];
    [moviePlayer release];
    
}
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSString*)LoadHtmlString:(NSURL*)url
{
	NSString *htmlString = [NSString stringWithFormat:
							@"<html>"
							"<head>"
							"<script type=\"text/javascript\" >"
							"function display(img){"
							"var imgOrigH = document.getElementById('image').offsetHeight;"
							"var imgOrigW = document.getElementById('image').offsetWidth;"
							"var bodyH = window.innerHeight;"
							"var bodyW = window.innerWidth;"
							"if((imgOrigW/imgOrigH) > (bodyW/bodyH))"
							"{"
							"document.getElementById('image').style.width = bodyW + 'px';"
							"document.getElementById('image').style.top = (bodyH - document.getElementById('image').offsetHeight)/2  + 'px';"
							"}"
							"else"
							"{"
							"document.getElementById('image').style.height = bodyH + 'px';"
							"document.getElementById('image').style.marginLeft = (bodyW - document.getElementById('image').offsetWidth)/2  + 'px';"
							"}"
							"}"
							"</script>"                         
							"</head>"
							"<body style=\"margin:0;width:100%;height:100%;\" >"
							"<img id=\"image\" src=\"%@\" onload=\"display()\" style=\"position:relative\" />"
							"</body>"
							"</html>",url
							];
	
	return htmlString;
}

-(void)parsingFinixh:(NSDictionary*)dic
{
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (onIphone) {
        
        webing.frame = CGRectMake(0, 0, 320, 161);
        
        iphoneBtn.hidden=FALSE;
        deletePressed.hidden=FALSE;
        saveToIphone.hidden=TRUE;
        
        
    }else{
        
        saveToIphone.hidden=FALSE;
        iphoneBtn.hidden=TRUE;
        deletePressed.hidden=TRUE;
        btnPlay.hidden=TRUE;
        
    }
    redProgressBar = [[ADVPercentProgressBar alloc] initWithFrame:CGRectMake(10, 130, 292, 28) andProgressBarColor:ADVProgressBarRed];
    
    redProgressBar.hidden=YES;
    [self.view addSubview:redProgressBar];
    
}






- (void)viewDidUnload
{
    [webing release];
    webing = nil;
    [description release];
    description = nil;
    [nameTitle release];
    nameTitle = nil;
    [createdDateTile release];
    createdDateTile = nil;
    [iphoneBtn release];
    iphoneBtn = nil;
    [deletePressed release];
    deletePressed = nil;
    [indicator release];
    indicator = nil;
    [saveToIphone release];
    saveToIphone = nil;
    [inageVi release];
    inageVi = nil;
 //   [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  YES ;
    
      
}

- (IBAction)iphonePressed:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Downloading" message:@"Your video is now being downloaded" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}

- (IBAction)deletePressed:(id)sender {
    
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"oniPhone"]];
    
    NSMutableArray *temp1 = [[NSMutableArray alloc]init];
    
    
    for (int i=0; [temp count]>i; i++) {
        
        
        if ([[temp objectAtIndex:i]  isEqualToString:[dictionary valueForKey:@"vdo_id"]]) {
            
            
        }  else{
            
            [temp1 addObject:[temp objectAtIndex:i]];
            
        }
        
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:temp1 forKey:@"oniPhone"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [temp1 release];
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Video Deleted" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [indicator startAnimating];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [indicator stopAnimating];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    [indicator startAnimating];
    return YES;
}

- (IBAction)buttonPlay:(id)sender {
    
    NSString *strUrl;
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [documentPath objectAtIndex:0];
    
    NSString *newPlistFile  = [documentFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[dictionary valueForKey:@"vdo_id"]]];
    
    if (onIphone) {
         
        NSURL  *movieURL = [NSURL fileURLWithPath:newPlistFile];
        
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
        moviePlayer.view.frame = self.view.frame;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
           
        [self.view addSubview:moviePlayer.view];
        [moviePlayer play];
        
    }else{
      
        
        
        strUrl = [NSString stringWithFormat:@"%@?vdo_id=%@",videoPlay,[dictionary valueForKey:@"vdo_id"]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
        
        [webing loadRequest:request];
        webing.mediaPlaybackRequiresUserAction=YES;
        [indicator startAnimating];
        
    }
    
    
    
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{      
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NULL
                                                  object:nil];
    [moviePlayer.view removeFromSuperview];
    [moviePlayer release];
}











-(void)InsertInLocal{
       
    
    NSString *str = [[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"VdoUrl"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // http://app1.anthonyrey.com/audio/mixtapes/Mixtape3.mp3
    
    // http://brightcove.vo.llnwd.net/e1/uds/pd/1490757865001/1490757865001_1565523390001_06-Wardian-cross-training-road.mp4
    if([str isEqualToString:@"NOURLADDED"]){
    

    }
    else{
    
    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"oniPhone"]];
    
    [temp addObject:[dictionary valueForKey:@"vdo_id"]];
    
    [[NSUserDefaults standardUserDefaults]setValue:temp forKey:@"oniPhone"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [temp release];
    
   
    self.onIphone=TRUE;
        iphoneBtn.hidden=FALSE;
        deletePressed.hidden=FALSE;
        saveToIphone.hidden=TRUE;
    NSURL *url = [NSURL URLWithString:str];
    
    
    NSLog (@"HI  %@",url);
    NSLog (@"HI  %@",str);
    
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setHTTPMethod:@"GET"];
    
    NSError *error;
    NSURLResponse *response;
    
    NSString *documentFolderPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
        
    NSString *strUrl = [[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"VdoUrl"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"STr Url %@",strUrl);
    
    NSData *urlData;
    // NSString *downloadPath = @"http://brightcove.vo.llnwd.net/e1/uds/pd/1490757865001/1490757865001_1565523390001_06-Wardian-cross-training-road.mp4";
    
    [request setURL:[NSURL URLWithString:strUrl]];
    urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
   
    NSString *filePath = [documentFolderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[dictionary valueForKey:@"vdo_id"]]];
    
    
    BOOL written = [urlData writeToFile:filePath atomically:NO];
    if (written)
        NSLog(@"Saved to file: %@", filePath);
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request1 delegate:self];
    [conn start];
    [request1 release];
    [url release];
    request1 = nil;
    url = nil;
    [indicator stopAnimating];
    
        redProgressBar.hidden=YES;
    }
    
}





-(void)count:(NSTimer*)timer {
   
    
    if (ij >= 100) {
        [timer invalidate];
        [progressTimer invalidate];
        redProgressBar.hidden=TRUE;
    }
    
    int percent = ij;
    NSString* string = [NSString stringWithFormat:@"%i", percent];
    string = [string stringByAppendingString:@"%"];
  
    
    [redProgressBar setProgress:ij];
    ij++;
}
- (void)changeProgressValue
{
    float progressValue = redProgressBar.progress;
    
    progressValue       += 0.03f;
    if (progressValue > 1)
    {
        redProgressBar.hidden=TRUE;
        progressValue = 0;
    }
    [redProgressBar setProgress:progressValue];
    
    
}
- (void) cycle {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    
    progressTimer = [NSTimer scheduledTimerWithTimeInterval:3
                                                target:self
                                              selector:@selector(changeProgressValue)
                                              userInfo:nil
                                               repeats:YES];
    
	[runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    [pool release];
}
- (void) stopTimer
{
    [progressTimer invalidate];
    progressTimer = nil;
}
- (IBAction)saveToIphonePressed:(id)sender {
   
    
    [indicator startAnimating];
    redProgressBar.hidden=NO;
    [NSThread detachNewThreadSelector:@selector(cycle)
                             toTarget:self withObject:nil];
    [timerThread start];
  
    [self performSelector:@selector(InsertInLocal) withObject:self afterDelay:0.1];
    
     
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
  //  NSLog (@"HI data  %@",data);
     
    //    if(!songData)
    //    {
    //        songData = [[NSMutableData alloc] init];
    //    }
    //    else
    //    {
    //        [songData appendData:data];
//        totalDownloadedData += [data length]; // global integer
//        redProgressBar.progress = totalDownloadedData/size;
    //
    //    }
    //
    //    [songData writeToFile:@"" atomically:YES];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
 //  NSLog (@"HI  response  %@",response);
    
    
    
    
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // NSLog (@"HI error  %@",error);
    
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    //    
    //    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentFolder = [documentPath objectAtIndex:0];
    //    
    //    NSString *newPlistFile  = [documentFolder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",[dictionary valueForKey:@"vdo_id"]]];
    //        
    //    NSLog(@"%@",newPlistFile);
    //    
    //    [songData writeToFile:newPlistFile atomically:YES];
    //    [alert1 dismissWithClickedButtonIndex:0 animated:YES];
    
    //  [connection release];
    // connection = nil;
}




@end
