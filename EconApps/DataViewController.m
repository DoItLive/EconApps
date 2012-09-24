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

@synthesize view, scrollView, cells, tables, data, numCols, numRows, cellWidth, cellHeight, colHigh, rowHigh;

- (id)initWithFrame:(CGRect)frame andData:(NSMutableArray*)dataInput
{
    if (self) {
        //Build overall view with frame
        self.view = [[UIView alloc] initWithFrame:frame];
        
        //Set up the data source and #rows and columns
        [self setData:dataInput];
        [self setNumCols: [[NSNumber alloc] initWithInt:[self.data count]]];
        [self setNumRows: [[NSNumber alloc] initWithInt:[[self.data objectAtIndex:0] count]]];
        [self setColHigh:[[NSNumber alloc] initWithInt:0]];
        [self setRowHigh:[[NSNumber alloc] initWithInt:0]];
        
        
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
        self.tables = [[NSMutableArray alloc] initWithCapacity:2*([self.numCols intValue] + 1)];
        self.cells = [[NSMutableArray alloc] initWithCapacity:([self.numCols intValue] + 1)*([self.numRows intValue] + 1)];
        
        for (int i=0;i<[self.numCols intValue];i++){
            UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake((i + 1)*([cellWidth intValue] + 1), 0, [self.cellWidth intValue], [self.cellHeight intValue])];
            [t setDelegate:self];
            [t setDataSource:self];
            t.showsVerticalScrollIndicator = NO;
            t.backgroundColor = [UIColor clearColor];
            t.separatorColor = [UIColor purpleColor];
            t.rowHeight = [cellHeight intValue];
            t.bounces = FALSE;
            [self.tables addObject:t];
            [self.view addSubview:t];
        }
        
        for (int i=0;i<[self.numCols intValue] + 1;i++){
            UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(i*([cellWidth intValue] + 1), 0, [cellWidth intValue], self.scrollView.contentSize.height)];
            [t setDelegate:self];
            [t setDataSource:self];
            t.showsVerticalScrollIndicator = NO;
            t.backgroundColor = [UIColor clearColor];
            t.separatorColor = [UIColor purpleColor];
            t.rowHeight = [cellHeight intValue];
            [self.tables addObject:t];
            [self.scrollView addSubview:t];
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
    NSInteger curRow = [indexPath row];
    
    NSString* text;
    
    if(tableView.superview == self.view){
        text = [[NSString alloc] initWithFormat:@"%d",curTable - 1];
    } else {
        if(curTable == 0){
            text = [[NSString alloc] initWithFormat:@"%d",curRow];
        } else{
            int num = [[(NSMutableArray*)[self.data objectAtIndex:curTable - 1] objectAtIndex:curRow] intValue];
            text = [[NSString alloc] initWithFormat:@"%d",num];
        }
    }
        
    [[cell textLabel] setText:text];
    cell.textLabel.textAlignment = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.cells addObject:cell];
    
    if ([self.cells count] >= ([self.numCols intValue] + 1)*([self.numRows intValue] + 1) - 1) {
        [self setUpHierarchy];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.superview == self.view || !((int)tableView.frame.origin.x/[cellWidth intValue])) {
        cell.backgroundColor = [UIColor colorWithRed:.27 green:.51 blue:.71 alpha:1]; //steel blue
    } else if (!([indexPath row] % 2)){
        //if (!((int)tableView.frame.origin.x/[cellWidth intValue])) {
            cell.backgroundColor = [UIColor whiteColor];
        //} else {
        //    cell.backgroundColor = [UIColor colorWithRed:1 green:.88 blue:1 alpha:1]; //light thistle
        //}  [UIColor colorWithRed:.27 green:.51 blue:.71 alpha:1]; //steel blue
        
    } else {
        //if (!((int)tableView.frame.origin.x/[cellWidth intValue])) {
        //    cell.backgroundColor = [UIColor colorWithRed:.69 green:.77 blue:.87 alpha:1]; //light steel blue
        //} else {
            cell.backgroundColor = [UIColor colorWithRed:.93 green:.82 blue:.93 alpha:1]; //light thistle
        //}
    }
}



#pragma mark - Table view delegate

- (void)setUpHierarchy
{
    [self.cells addObject:[self.cells objectAtIndex:0]];
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:[self.cells count]];
    [tmp addObjectsFromArray:self.cells];
    for (int i = 0; i < [tmp count]; i++) {
        UITableViewCell *cell = [tmp objectAtIndex:i];
        UITableView *table = (UITableView*)cell.superview;
        NSInteger rowNum = [[table indexPathForCell:cell] row];
        if(i == [tmp count] - 2){
            table = (UITableView*)((UITableViewCell*)[self.cells objectAtIndex:[self.numCols intValue] + 1]).superview;
            rowNum = [self.numRows intValue] - 1;
        }
        NSInteger colNum = (int)table.frame.origin.x/[cellWidth intValue];
        NSInteger indexNum;
        if (table.superview == self.view) {
            indexNum = colNum;
        } else {
            indexNum = (rowNum + 1)*([self.numCols intValue] + 1) + colNum;
        }
        
        [self.cells replaceObjectAtIndex:indexNum withObject:cell];
    }
}

- (void)updateSelectedRow:(NSInteger)rowNum
{
    UITableViewCell *tmp;
    for (int i = 0; i < [self.numCols intValue] + 1; i++) {
        if(i != [colHigh intValue]){
            tmp = [self.cells objectAtIndex:([rowHigh intValue]*([self.numCols intValue] + 1) + i)];
            [self tableView:(UITableView*)tmp.superview willDisplayCell:tmp forRowAtIndexPath:[(UITableView*)tmp.superview indexPathForCell:tmp]];
        }
    }
    if (rowNum != 0) {
        for (int i = 0; i < [self.numCols intValue] + 1; i++) {
            ((UITableViewCell*)[self.cells objectAtIndex:(rowNum*([self.numCols intValue] + 1) + i)]).backgroundColor = [UIColor colorWithRed:1 green:.96 blue:.56 alpha:1]; //light khaki
        }
    }
    [self setRowHigh:[[NSNumber alloc] initWithInt:rowNum]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger curTable = (int)tableView.frame.origin.x/[cellWidth intValue];
    if(curTable){
        UITableViewCell *tmp;
        for (int i = 0; i < [self.numRows intValue] + 1; i++) {
            if(!i || i != [rowHigh intValue]){
                tmp = [self.cells objectAtIndex:([colHigh intValue] + ([self.numCols intValue] + 1)*i)];
                [self tableView:(UITableView*)tmp.superview willDisplayCell:tmp forRowAtIndexPath:[(UITableView*)tmp.superview indexPathForCell:tmp]];
            }
        }
        for (int i = 0; i < [self.numRows intValue] + 1; i++) {
            ((UITableViewCell*)[self.cells objectAtIndex:(curTable + ([self.numCols intValue] + 1)*i)]).backgroundColor = [UIColor colorWithRed:1 green:.96 blue:.56 alpha:1]; //light khaki
        }
        [self setColHigh: [[NSNumber alloc] initWithInt:curTable]];
    }
}

@end