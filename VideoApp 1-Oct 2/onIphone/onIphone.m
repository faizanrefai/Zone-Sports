//
//  onIphone.m
//  VideoApp
//
//  Created by  on 20/06/12.
//  Copyright 2012 . All rights reserved.
//

#import "onIphone.h"
#import "VideoDetailView.h"
#import "JSONParser.h"
#import "WSStatic.h"
@implementation onIphone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
   // self.title = @"<<";
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [indicator startAnimating];
    NSString *strUrl = [NSString stringWithFormat:@"%@?action=user_video&userid=%@",allVideolist,[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl]];
    
        JSONParser *parser  = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(parsingFinixh:) andHandler:self];
        NSLog(@"%@",parser);
    

    
}

-(void)parsingFinixh:(NSDictionary*)dic
{

    //NSLog(@"%@",dic);
    
    
    NSMutableArray *temp = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"oniPhone"]];
    
    NSMutableArray *temp1 = [[NSMutableArray alloc]init];
    
    
    for (int i=0; [temp count]>i; i++) {
        
        
        for (int j=0; [[dic valueForKey:@"video_list"]count]>j; j++) {
            
            
            
            if ([[temp objectAtIndex:i]  isEqualToString:[[[dic valueForKey:@"video_list"]  objectAtIndex:j] valueForKey:@"vdo_id"]]) {
                
               
                if ([temp1 containsObject:[[dic valueForKey:@"video_list"]objectAtIndex:j]]) {
                    
                    
                }
                else {
                    
                    [temp1 addObject:[[dic valueForKey:@"video_list"]objectAtIndex:j]];

                }
                             
            
                
                
            }  else{
                
                
                
            }
            
        }
        
    }
    
    
        
    [videoList removeAllObjects];
    [videoList addObjectsFromArray:temp1];
    
    [selectedVideoArry removeAllObjects];
    
    for (NSDictionary *dic in videoList) {
        
        [selectedVideoArry addObject:@"0"];
        
    }
    

    
    [indicator stopAnimating];

    [myTable reloadData];

}


- (void)dealloc
{
    [tableCell release];
    [myTable release];
    [namevideoLabel release];
    [timelabel release];
    [createdAtlabel release];
    [indicator release];
    [imageVi release];
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
        
        [[NSBundle mainBundle] loadNibNamed:@"OniphoneCell" owner:self options:nil];
        cell=tableCell;
        
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

    
    namevideoLabel.text = [NSString stringWithFormat:@"%@",  [[videoList objectAtIndex:indexPath.row] valueForKey:@"name"]];
    timelabel.text = [NSString stringWithFormat:@"%@",  [[videoList objectAtIndex:indexPath.row] valueForKey:@"length"]];
    createdAtlabel.text = [NSString stringWithFormat:@"%@",  [[videoList objectAtIndex:indexPath.row] valueForKey:@"created_at"]];
    
    NSString *imgUrlStr = [[NSString stringWithFormat:@"%@",  [[videoList objectAtIndex:indexPath.row] valueForKey:@"thumbUrl"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    imageVi.imageURL = [NSURL URLWithString:imgUrlStr];
    
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
    bu.onIphone=TRUE;
    
    [self.navigationController pushViewController:bu animated:YES];
        
    }
   

}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"";
    self.navigationItem.title =@"Saved Videos";

    
    videoList=[[NSMutableArray alloc]init];
    selectedVideoArry=[[NSMutableArray alloc]init];
    
    
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editPressed:)];
    isEditing =NO;
    self.navigationItem.rightBarButtonItem = btn2;
    [btn2 release];

    
    // Do any additional setup after loading the view from its nib.
}

-(void)editPressed:(UIBarButtonItem*)sender
{
    
    if (isEditing==NO) {
        
        UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(editPressed:)];
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
       
        NSMutableArray *temp1 = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]valueForKey:@"oniPhone"]];
        
        
        for (int i=0;[selectedVideoArry count]>i ; i++) {
            
            
            if ([[selectedVideoArry objectAtIndex:i]isEqualToString:@"0"]) {
                
                
                
            }else {
                
                [temp1 removeObject:[[videoList objectAtIndex:i] valueForKey:@"vdo_id"]];
                
            }
            
            [selectedVideoArry replaceObjectAtIndex:i withObject:@"0"];
            
        }
        
        
        [temp removeAllObjects];
        [temp addObjectsFromArray:temp1];
        [[NSUserDefaults standardUserDefaults]setValue:temp forKey:@"oniPhone"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

        
     //   NSLog(@"temp========%@",temp);

        [temp release];
        [myTable reloadData];
        
        [self viewWillAppear:YES];
        
    }
    
    
}


- (void)viewDidUnload
{
    [tableCell release];
    tableCell = nil;
    [myTable release];
    myTable = nil;
    [namevideoLabel release];
    namevideoLabel = nil;
    [timelabel release];
    timelabel = nil;
    [createdAtlabel release];
    createdAtlabel = nil;
    [indicator release];
    indicator = nil;
    [imageVi release];
    imageVi = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
