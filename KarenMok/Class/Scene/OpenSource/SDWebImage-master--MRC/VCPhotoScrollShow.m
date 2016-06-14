//
//  VCPhotoScrollShow.m
//  SNSRenRen01
//
//  Created by a a a a a on 13-2-27.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "VCPhotoScrollShow.h"

@implementation VCPhotoScrollShow
@synthesize mScrollView ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    
    mScrollView.contentSize = CGSizeMake(320, 400*2);
    mScrollView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:mScrollView];
    

    
    for ( int i = 0 ; i < 15; i++) 
    {
        UITapGestureRecognizer* tapGes = [[UITapGestureRecognizer alloc] init];
        [tapGes addTarget:self action:@selector(pressImage:)];
        UIImageView* iv01 = [[UIImageView alloc] initWithFrame:CGRectMake(30+100.0*(i%3), 30+120.0*(i/3), 80, 100)];
        iv01.image = [UIImage imageNamed:[NSString stringWithFormat:@"2_%d.jpg",i+1]];
        
        [mScrollView addSubview:iv01];
        
        iv01.userInteractionEnabled = YES ;
        
        [iv01 addGestureRecognizer:tapGes];
        [tapGes release];
    }  
}

-(void) pressImage:(UIGestureRecognizer*) ges
{
    static BOOL isBig = NO;
    static CGRect frameOld ;
    NSLog(@"aaa");
    
    UIImageView* view = (UIImageView*)ges.view ;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    if (isBig == NO) {
        frameOld = view.frame ;
        view.frame = CGRectMake(mScrollView.contentOffset.x, mScrollView.contentOffset.y, 320, 400);
        [mScrollView bringSubviewToFront:view];
    }
    else
    {
        view.frame = frameOld;
    }
    isBig = ! isBig ;
    [UIView commitAnimations];


}


- (void)viewDidUnload
{
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
