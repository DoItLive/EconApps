/*
#import "TileScroller.h"

@implementation TileScroller

@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)init{
    
    numTiles = 0;
    self = [super initWithFrame:CGRectMake(0, 390, 320, 70)];
    UIImageView* bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Options_Bar.png"]];
    bg.frame = CGRectMake(0, 0, 320, 70);
    [self addSubview:bg];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 5, 310, 60)];
    scrollView.contentSize = CGSizeMake(1, 1);
    scrollView.showsHorizontalScrollIndicator = FALSE;
    [self addSubview:scrollView];
    
    return self;
    
}

-(void)addtileWithTitle:(NSString*)title andSelector:(SEL)func withTarget:(id)target{
    
    UIImageView* tile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Block_tile"]];   
    [tile setFrame:CGRectMake(3+numTiles*59, 3, 54, 54)];
    [scrollView addSubview:tile];
    numTiles++;
    scrollView.contentSize = CGSizeMake(numTiles*59+3, 1);

    
}

@end
*/