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

@synthesize view, style, allowHighlighting, numberBuilt, scrollView, cells, tables, data, numberOfColumns, numberOfRows, cellWidth, cellHeight, highlightedColumn, highlightedRow;

- (id)initWithFrame:(CGRect)frameIn andData:(NSMutableArray*)dataIn andStyle:(TABLE_STYLE)styleIn
{
    if (self) {
        
        //Set up view, data, and style
        [self setView:[[UIView alloc] initWithFrame:frameIn]];
        [self setData:dataIn];
        [self setStyle:styleIn];
        
        
        //Set up important values
        [self setNumberOfColumns:[[NSNumber alloc] initWithInt:[self.data count]]];
        [self setNumberOfRows:[[NSNumber alloc] initWithInt:[[self.data objectAtIndex:0] count]]];
        
        if (self.style == kUNIFORM) {
            [self setAllowHighlighting:YES];
        } else {
            [self setAllowHighlighting:NO];
        }
        
        if (self.allowHighlighting) {
            [self setHighlightedColumn:[[NSNumber alloc] initWithInt:1]];
            [self setHighlightedRow:[[NSNumber alloc] initWithInt:0]];
        }

        [self setCellHeight:[[NSNumber alloc] initWithInt:44]]; //default is 44
        
        if (style == kUNIFORM) {
            [self setCellWidth:[[NSNumber alloc] initWithInt:self.view.frame.size.width/[self.numberOfColumns intValue] - 1]];
        }
        
        //Build the scrollview for the tableviews filling up the frame minus one cell height for the column headers
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [self.cellHeight intValue], self.view.frame.size.width, self.view.frame.size.height - [self.cellHeight intValue])];
        self.scrollView.showsHorizontalScrollIndicator = FALSE;
        self.scrollView.bounces = FALSE;
        [self.view addSubview:self.scrollView];
        
        //Content size big enough so that tables won't scroll
        [self.scrollView setContentSize: CGSizeMake(self.view.frame.size.width,([self.numberOfRows intValue] - 1)*[self.cellHeight intValue])];
        
        self.tables = [[NSMutableArray alloc] initWithCapacity:[self.numberOfColumns intValue]*2];
        self.cells = [[NSMutableArray alloc] initWithCapacity:[self.numberOfColumns intValue]*[self.numberOfRows intValue]];
        
        UITableViewCell *cell;
        static NSString *CellIdentifier = @"Cell";
        if (cell==nil)
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        for (int i = 0; i < [self.numberOfColumns intValue]*[self.numberOfRows intValue]; i++) {
            [self.cells addObject:cell];
        }
        [self setNumberBuilt:0];
        
        for (int i = 0; i < [self.numberOfColumns intValue]*2; i++){
            if (!(!i && self.style == kUNIFORM)) {
                int j = i%[self.numberOfColumns intValue];
                int currentCellWidth = [self.cellWidth intValue];
                if (self.style == kNON_UNIFORM) {
                    currentCellWidth = [self cellWidthForColumn:j];
                }
                int currentOriginX;
                if (!j) {
                    currentOriginX = 1;
                } else if (i == 1 && self.style == kUNIFORM) {
                    currentOriginX = [self.cellWidth intValue] + 2;
                } else {
                    currentOriginX = ((UITableView*)[self.tables objectAtIndex:[self.tables count] - 1]).frame.origin.x + ((UITableView*)[self.tables objectAtIndex:[self.tables count] - 1]).frame.size.width + 1;
                }
                int currentHeight;
                if (i < [self.numberOfColumns intValue]) {
                    currentHeight = [self.cellHeight intValue];
                } else {
                    currentHeight = ([self.numberOfRows intValue] - 1)*[self.cellHeight intValue];
                }
                UITableView *t = [[UITableView alloc] initWithFrame:CGRectMake(currentOriginX, 0, currentCellWidth, currentHeight)];
                [t setDelegate:self];
                [t setDataSource:self];
                t.showsVerticalScrollIndicator = NO;
                t.backgroundColor = [UIColor clearColor];
                t.separatorColor = [UIColor purpleColor];
                t.rowHeight = [cellHeight intValue];
                t.bounces = FALSE;
                [self.tables addObject:t];
                if (i < [self.numberOfColumns intValue]) {
                    [self.view addSubview:t];
                } else {
                    [self.scrollView addSubview:t];
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
        return [self.numberOfRows intValue] - 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //Get the current table by grabbing its topleft corner and dividing by its size
    NSInteger currentRow = [indexPath row];
    NSInteger currentColumn;
    NSInteger j = [self.tables indexOfObject:tableView];
    if (self.style == kUNIFORM) {
        currentColumn = (j + 1)%[self.numberOfColumns intValue];
        if (j + 1 >= [self.numberOfColumns intValue]) {
            currentRow++;
        }
    } else {
        currentColumn = j%[self.numberOfColumns intValue];
        if (j >= [self.numberOfColumns intValue]) {
            currentRow++;
        }
    }
    
    [[cell textLabel] setText:[[self.data objectAtIndex:currentColumn] objectAtIndex:currentRow]];
    
    cell.textLabel.textAlignment = 1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.numberBuilt < [self.cells count]) {
        NSInteger indexNum = currentRow*[self.numberOfColumns intValue] + currentColumn;
        [self.cells replaceObjectAtIndex:indexNum withObject:cell];
        self.numberBuilt++;
        //[[cell textLabel] setText:[[NSString alloc] initWithFormat:@"%d",indexNum]];
        if (self.numberBuilt + 1 == [self.cells count]) {
            [self updateSelectedColumn:1];
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger currentRow = [indexPath row];
    NSInteger currentColumn;
    NSInteger j = [self.tables indexOfObject:tableView];
    if (self.style == kUNIFORM) {
        currentColumn = (j + 1)%[self.numberOfColumns intValue];
        if (j + 1 >= [self.numberOfColumns intValue]) {
            currentRow++;
        }
    } else {
        currentColumn = j%[self.numberOfColumns intValue];
        if (j >= [self.numberOfColumns intValue]) {
            currentRow++;
        }
    }
    if (!currentRow || !currentColumn) {
        cell.backgroundColor = [UIColor colorWithRed:.27 green:.51 blue:.71 alpha:1]; //steel blue
    } else if (currentRow%2){
        cell.backgroundColor = [UIColor whiteColor];  
    } else {
        cell.backgroundColor = [UIColor colorWithRed:.93 green:.82 blue:.93 alpha:1]; //light thistle
    }
}



#pragma mark - Table view delegate

- (int)cellWidthForColumn:(int)columnIn
{
    double headerTotal = 0;
    for (int i = 0; i < [self.numberOfColumns intValue]; i++) {
        headerTotal+=[(NSString *)[[self.data objectAtIndex:i] objectAtIndex:0] length];
    }
    double columnLength = [(NSString *)[[self.data objectAtIndex:columnIn] objectAtIndex:0] length];
    double ratio = columnLength/headerTotal;
    NSInteger  size = ((int)(ratio*self.view.frame.size.width + .5)) - 1;
    
    NSLog(@"size %d",size);
    return size;
}


- (void)updateSelectedColumn:(NSInteger)stackSize
{
    if (allowHighlighting) {
        NSInteger currentColumn = stackSize;
        if(currentColumn){
            UITableViewCell *tmp;
            for (int i = 0; i < [self.numberOfRows intValue]; i++) {
                if(!i || i != [highlightedRow intValue]){
                    tmp = [self.cells objectAtIndex:([highlightedColumn intValue] + [self.numberOfColumns intValue]*i)];
                    [self tableView:(UITableView*)tmp.superview willDisplayCell:tmp forRowAtIndexPath:[(UITableView*)tmp.superview indexPathForCell:tmp]];
                }
            }
            for (int i = 0; i < [self.numberOfRows intValue]; i++) {
                ((UITableViewCell*)[self.cells objectAtIndex:(currentColumn + [self.numberOfColumns intValue]*i)]).backgroundColor = [UIColor colorWithRed:1 green:.96 blue:.56 alpha:1]; //light khaki
            }
            [self setHighlightedColumn: [[NSNumber alloc] initWithInt:currentColumn]];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (allowHighlighting) {
        UITableViewCell *tmp;
        for (int i = 0; i < [self.numberOfColumns intValue]; i++) {
            if(i != [highlightedColumn intValue] || ![highlightedColumn intValue]){
                tmp = [self.cells objectAtIndex:([highlightedRow intValue]*[self.numberOfColumns intValue] + i)];
                [self tableView:(UITableView*)tmp.superview willDisplayCell:tmp forRowAtIndexPath:[(UITableView*)tmp.superview indexPathForCell:tmp]];
            }
        }
    
        NSInteger currentRow = [indexPath row];
        NSInteger j = [self.tables indexOfObject:tableView];
        if (self.style == kUNIFORM) {
            if (j + 1 >= [self.numberOfColumns intValue]) {
                currentRow++;
            }
        } else {
            if (j >= [self.numberOfColumns intValue]) {
                currentRow++;
            }
        }
    
        if (currentRow != 0) {
            for (int i = 0; i < [self.numberOfColumns intValue]; i++) {
                ((UITableViewCell*)[self.cells objectAtIndex:(currentRow*[self.numberOfColumns intValue] + i)]).backgroundColor = [UIColor colorWithRed:1 green:.96 blue:.56 alpha:1]; //light khaki
            }
        }
        [self setHighlightedRow:[[NSNumber alloc] initWithInt:currentRow]];
    }
}

@end