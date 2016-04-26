//
//  AllVideo.m
//  VideoApp
//
//  Created by  on 20/06/12.
//  Copyright 2012 . All rights reserved.
//

#import "AllVideo.h"
#import "VideoDetailView.h"
#import "JSONParser.h"
#import "WSStatic.h"
#import "WebViewController.h"

@implementation AllVideo
@synthesize searchIndicator;
@synthesize popLeftView;

int i=0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [popLeftView release];
    [tablCell release];
    [myTable release];
    [namelabel release];
    [deratedDatelabel release];
    [lenghthlabel release];
    [indicator release];
    [searchTxt release];
    [searchBYNameBtn release];
    [searcgByDateBtn release];
    [datePicker release];
    [searchIndicator release];
    [imageVdo release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [videoList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
       
        [[NSBundle mainBundle] loadNibNamed:@"AllVideoCell" owner:self options:nil];
        cell=tablCell;
        
    }
    
    if ([[selectedVideoArry objectAtIndex:indexPath.row]isEqualToString:@"1"]) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick-mark-btn.png"]];
        cell.accessoryView = imageView;

    }
    else {
        if(isEditing)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unchecked-img.png"]];
            cell.accessoryView = imageView;
        }
    }
    
    
    namelabel.text =[NSString stringWithFormat:@"%@",  [[videoList objectAtIndex:indexPath.row] valueForKey:@"name"]];
    lenghthlabel.text =[NSString stringWithFormat:@"%@",   [[videoList objectAtIndex:indexPath.row] valueForKey:@"length"]];
    deratedDatelabel.text = [NSString stringWithFormat:@"%@",  [[videoList objectAtIndex:indexPath.row] valueForKey:@"created_at"]];
 
    NSString *imgUrlStr = [[NSString stringWithFormat:@"%@",  [[videoList objectAtIndex:indexPath.row] valueForKey:@"thumbUrl"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // NSLog(@"%@",imgUrlStr);
    
    imageVdo.imageURL = [NSURL URLWithString:imgUrlStr];
  
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    if (isEditing) {
        
        if ([[selectedVideoArry objectAtIndex:indexPath.row]isEqualToString:@"0"]) {
          
            [selectedVideoArry replaceObjectAtIndex:indexPath.row withObject:@"1"];
            [myTable reloadData];

        }else {
            [selectedVideoArry replaceObjectAtIndex:indexPath.row withObject:@"0"];
            [myTable reloadData];

        }
         
        
    }else {
        
         
        VideoDetailView *bu = [[VideoDetailView alloc]initWithNibName:@"VideoDetailView" bundle:nil];
        [bu.dictionary addEntriesFromDictionary:[videoList objectAtIndex:indexPath.row] ];
        
        
        NSMutableArray *temp = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"oniPhone"]];
        
        
        for (int i=0; [temp count]>i; i++) {
            
            
            if ([[temp objectAtIndex:i]  isEqualToString:[[videoList  objectAtIndex:indexPath.row ] valueForKey:@"vdo_id"]]) {
                
                bu.onIphone=TRUE;
                break;
                
                
            }  else{
                
                bu.onIphone=FALSE;
                
            }
             
        }
        
        [self.navigationController pushViewController:bu animated:YES];
        
    }
    
  
}

-(void)viewWillDisappear:(BOOL)animated
{

}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
  //  self.title = @"";
    self.navigationItem.title =@"All Videos";

    
    videoList  = [[NSMutableArray alloc]init];
    
    selectedVideoArry  = [[NSMutableArray alloc]init];

    UIImage *faceImage = [UIImage imageNamed:@"1341386855_check-all"];
    
    
//    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
//    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
//    [face setImage:faceImage forState:UIControlStateNormal];
//    UIBarButtonItem *faceBtn = [[UIBarButtonItem alloc] initWithCustomView:face];
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc]ini:@"==" style:UIBarButtonItemStyleBordered target:self action:@selector(leftButtonItemPres:)];
    
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:faceImage style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonItemPres:)];
    self.navigationItem.leftBarButtonItem = btn;
    [btn release];
    
    
    btn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPressed:)];
    isEditing =NO;
    self.navigationItem.rightBarButtonItem = btn2;
   // [btn2 release];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnClick:(id)sender
{
    self.navigationController.navigationBarHidden=YES;
    WebViewController* web = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    
    [self.navigationController pushViewController:web animated:YES];
    
}

-(void)editPressed:(UIBarButtonItem*)sender
{

    if (isEditing==NO) {
        
        UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(editPressed:)];
        
        isEditing =YES;
        self.navigationItem.rightBarButtonItem = btn2;
        [btn2 release];
        [myTable reloadData];
        
    }
    
    else {
      
        UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPressed:)];
        isEditing =NO;
        self.navigationItem.rightBarButtonItem = btn2;
        [btn2 release];
       
        
        
        NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"oniPhone"]];
          
        for (int i=0;[selectedVideoArry count]>i ; i++) {
            
            
            if ([[selectedVideoArry objectAtIndex:i]isEqualToString:@"0"]) {
                
               // do nothing 
                  
            }else {
               
                if ( [temp containsObject:[[videoList objectAtIndex:i] valueForKey:@"vdo_id"]]) {
                    
                }
                else {
                    
                    [temp addObject:[[videoList objectAtIndex:i] valueForKey:@"vdo_id"] ];
                    [[NSUserDefaults standardUserDefaults]setValue:temp forKey:@"oniPhone"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                }
                
            }

            [selectedVideoArry replaceObjectAtIndex:i withObject:@"0"];

        }
        
       // NSLog(@"temp========%@",temp);

        [temp release];
        [myTable reloadData];

    }
    

}

- (void)viewDidUnload
{
    [self setPopLeftView:nil];
    [tablCell release];
    tablCell = nil;
    [myTable release];
    myTable = nil;
    [namelabel release];
    namelabel = nil;
    [deratedDatelabel release];
    deratedDatelabel = nil;
    [lenghthlabel release];
    lenghthlabel = nil;
    [indicator release];
    indicator = nil;
    [searchTxt release];
    searchTxt = nil;
    [searchBYNameBtn release];
    searchBYNameBtn = nil;
    [searcgByDateBtn release];
    searcgByDateBtn = nil;
    [datePicker release];
    datePicker = nil;
    [self setSearchIndicator:nil];
    [imageVdo release];
    imageVdo = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)leftButtonItemPres:(id)sender {
    
    if (i==0) {
        
        popLeftView.frame = CGRectMake(-320, 0, 300, popLeftView.frame.size.height);   
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:popLeftView cache:NO];
        popLeftView.frame = CGRectMake(0, 0, 300, popLeftView.frame.size.height);   
        [self.view addSubview:popLeftView];
        [UIView commitAnimations];
        i=1;
        self.navigationItem.rightBarButtonItem = nil;
       // self.navigationItem.rightBarButtonItem.hi
        
    }else{
        
        
        popLeftView.frame = CGRectMake(0, 0, 300, popLeftView.frame.size.height);   
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:popLeftView cache:NO];
        popLeftView.frame = CGRectMake(-320, 0, 300, popLeftView.frame.size.height);   
        [UIView commitAnimations];
        i=0;
         self.navigationItem.rightBarButtonItem = btn2;
    }
    
       
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    [indicator startAnimating];

    NSString *strUrl = [NSString stringWithFormat:@"%@?action=user_video&userid=%@",allVideolist,[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
    
    JSONParser *parser  = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsingFinixh:) andHandler:self];
    NSLog(@"%@",parser);
    
    
    
}

-(void)parsingFinixh:(NSDictionary*)dic
{
    
 //   NSLog(@"%@",dic);
    
    [searchIndicator stopAnimating];

    
    [videoList removeAllObjects];
    [videoList addObjectsFromArray:[dic valueForKey:@"video_list"]];
    
    [selectedVideoArry removeAllObjects];
    
    for (NSDictionary *dic in videoList) {
        
        [selectedVideoArry addObject:@"0"];

    }
    
    
    
    [myTable reloadData];
    
    if ([videoList count]==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"No Data Found" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    [indicator stopAnimating];
   [self closeBtnPress:nil];

    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;

}
- (IBAction)closeBtnPress:(id)sender {
    
    if (i==0) {
        
//        popLeftView.frame = CGRectMake(-300, 0, 300, popLeftView.frame.size.height);   
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.8];
//        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:popLeftView cache:NO];
//        popLeftView.frame = CGRectMake(0, 0, 300, popLeftView.frame.size.height);   
//        [self.view addSubview:popLeftView];
//        [UIView commitAnimations];
//        i=1;
        
        
    }else{
        
        
        popLeftView.frame = CGRectMake(0, 0, 300, popLeftView.frame.size.height);   
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.8];
        [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:popLeftView cache:NO];
        popLeftView.frame = CGRectMake(-320, 0, 300, popLeftView.frame.size.height);   
        [UIView commitAnimations];
        i=0;
         self.navigationItem.rightBarButtonItem = btn2;
        
    }

    
}

- (IBAction)searchByNamePressed:(UIButton*)sender {
    
    searcgByDateBtn.selected=FALSE;
    searchBYNameBtn.selected=TRUE;

    [searchTxt becomeFirstResponder];
    datePicker.hidden=TRUE;
}

- (IBAction)searchByDate:(UIButton*)sender {
    
    
    searchBYNameBtn.selected=FALSE;
    searcgByDateBtn.selected=TRUE;
    [searchTxt resignFirstResponder];

    datePicker.hidden=FALSE;

    
}

- (IBAction)datepickerChanged:(UIDatePicker*)sender {
    

    NSDateFormatter *formattor = [[NSDateFormatter alloc]init];
    [formattor setDateFormat:@"yyyy-MM-dd"];
    
    searchTxt.text = [formattor stringFromDate: [datePicker date]];
    
    
    [formattor release];
    datePicker.hidden=TRUE;
    
    
    
}

- (IBAction)searchPresssed:(id)sender {
    
    NSString *strUrl ;
    
    [searchIndicator startAnimating];
    
    if (![searcgByDateBtn isSelected]) {
        
        strUrl = [NSString stringWithFormat:@"%@?action=filter_video&userid=%@&name=%@",allVideolist,[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"],searchTxt.text];

        
    }
    else{
    
        strUrl = [NSString stringWithFormat:@"%@?action=filter_video&userid=%@&created_at=%@",allVideolist,[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"],searchTxt.text];

    
    }
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
    
    JSONParser *parser  = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsingFinixh:) andHandler:self];
    NSLog(@"%@",parser);
    

    
    
}



@end
