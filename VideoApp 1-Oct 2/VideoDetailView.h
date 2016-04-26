//
//  VideoDetailView.h
//  VideoApp
//
//  Created by  on 21/06/12.
//  Copyright 2012 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "ADVPercentProgressBar.h"

#import <MediaPlayer/MediaPlayer.h>

@interface VideoDetailView : UIViewController  <UIWebViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate> {
    
    IBOutlet UIActivityIndicatorView *indicator;
    IBOutlet UIWebView *webing;
    
    IBOutlet UILabel *nameTitle;
    
    IBOutlet EGOImageView *inageVi;
    IBOutlet UIButton *saveToIphone;
    IBOutlet UIButton *iphoneBtn;
    float progress;
    IBOutlet UIButton *deletePressed;
    IBOutlet UILabel *createdDateTile;
    IBOutlet UITextView *description;
    
    float size;
    float  totalDownloadedData;
    NSMutableData *songData;
    UIProgressView *progressBar;
    UIProgressView *progressTintColorProgressView;
    UIAlertView*  alert1;
    MPMoviePlayerController  *moviePlayer;
    ADVPercentProgressBar *redProgressBar;
    IBOutlet UIButton *btnPlay;
     NSTimer*    progressTimer;
    NSThread *timerThread;
}
- (IBAction)iphonePressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
-(NSString*)LoadHtmlString:(NSURL*)url;
-(void)InsertInLocal;

@property (nonatomic,assign)BOOL onIphone;
- (IBAction)buttonPlay:(id)sender;

- (IBAction)saveToIphonePressed:(id)sender;
@property (nonatomic,retain)NSMutableDictionary *dictionary;

@end
