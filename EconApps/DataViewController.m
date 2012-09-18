//
//  DataView.m
//  EconApps
//
//  Created by Kevin Sanders on 9/13/12.
//  Copyright (c) 2012 High Point Univeristy. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

@synthesize view, scrollView, columns, data, numCols, numRows, cellWidth, cellHeight;

- (id)initWithFrame:(CGRect)frame andData:(NSMutableArray*)dataInput
{
    if (self) {
        //Build overall view with frame
        self.view = [[UIView alloc] initWithFrame:frame];
        
        //Set up the data source and #rows and columns
        [self setData:dataInput];
        [self setNumCols: [[NSNumber alloc] initWithInt:[self.data count]]];
        [self setNumRows: [[NSNumber alloc] initWithInt:[[self.data objectAtIndex:0] count]]];
        
        //Set the height of cells (default is 44)
        [self setCellHeight: [[NSNumber alloc] initWithInt:44]];
        
        //Calculate cell width based on number of columns +1 for the row headers
        [self setCellWidth: [[NSNumber alloc] initWithInt:frame.size.width/([self.numCols intValue] + 1) - 1]];
        
        //Build the scrollview for the tableviews filling up the frame minus one cell height for the column headers
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 + [cellHeight intValue], frame.size.width, frame.size.height - [cellHeight intValue])];
        self.scrollView.showsHorizontalScrollIndicator = FALSE;
        self.scrollView.bounces = FALSE;
        [self.view addSubview:self.scrollView];
        
        //Content size big enough so that tables won't scroll
        self.scrollView.contentSize = CGSizeMake(frame.size.width,[self.numRows intValue]*[self.cellHeight intValue]);
        
        //Holds all the data 
        self.columns = [[NSMutableArray alloc] initWithCapacity:[self.numCols intValue]];
        
        for (int i=0;i<[self.numCols intValue] + 1;i++){
            UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(i*([cellWidth intValue] + 1), 0, [cellWidth intValue], self.scrollView.contentSize.height)];
            [t setDelegate:self];
            [t setDataSource:self];
            t.showsVerticalScrollIndicator = NO;
            t.backgroundColor = [UIColor clearColor];
            t.separatorColor = [UIColor purpleColor];
            t.rowHeight = [cellHeight intValue];
            t.allowsSelection = FALSE;
            
            if (i%[self.numCols intValue]) {
               [self.columns addObject:t];
            }
            
            [self.scrollView addSubview:t];
        }
        
        for (int i=0;i<[self.numCols intValue];i++){
            UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake((i + 1)*([cellWidth intValue] + 1), 0, [self.cellWidth intValue], [self.cellHeight intValue])];
            [t setDelegate:self];
            [t setDataSource:self];
            t.showsVerticalScrollIndicator = NO;
            t.backgroundColor = [UIColor clearColor];
            t.separatorColor = [UIColor purpleColor];
            t.rowHeight = [cellHeight intValue];
            t.bounces = FALSE;
            t.allowsSelection = FALSE;
            
            [self.columns addObject:t];
            [self.view addSubview:t];
        }
        
        for (int i = 0; i < [self.columns count]; i += [self.numCols intValue]) {
            UITableView *t;
            t = [self.columns objectAtIndex:i];
            if (!(i%3)) {
                for (int j = 0; j < [self.numRows intValue]; i++) {
                    [t cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]].highlighted = TRUE;
                }
            } else {
                for (int j = 0; j < [self.numRows intValue]; i++) {
                    [t cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]].highlighted = FALSE;
                }
            }
        }
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView.superview == self.view){
        return 1;
    } else {
    
        return [self.numRows intValue];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //Get the current table by grabbing its topleft corner and dividing by its size
    NSInteger curTable = (int)tableView.frame.origin.x/[cellWidth intValue];
    NSString* text;
    
    if(tableView.superview == self.view){
        text = [[NSString alloc] initWithFormat:@"%d",curTable - 1];
    } else {
        NSInteger row = [indexPath row];
        if(curTable == 0){
            text = [[NSString alloc] initWithFormat:@"%d",row];
        } else{
            int num = [[(NSMutableArray*)[self.data objectAtIndex:curTable - 1] objectAtIndex:row] intValue];
            text = [[NSString alloc] initWithFormat:@"%d",num];
        }
    }
        
    [[cell textLabel] setText:text];
    cell.textLabel.textAlignment = 1;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(!([indexPath row] % 2)){
        cell.backgroundColor = [UIColor colorWithRed:.93 green:.82 blue:.93 alpha:1];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end