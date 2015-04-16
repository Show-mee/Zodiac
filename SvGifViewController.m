//
//  SvGifViewController.m
//  SvGifSample
//
//  Created by  maple on 3/28/13.
//  Copyright (c) 2013 smileEvday. All rights reserved.
//

#import "SvGifViewController.h"

#import "SvGifView.h"

@interface SvGifViewController () {
    SvGifView       *_gifView;
}

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

extern NSString * zodiacName;

@implementation SvGifViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* imageName = [zodiacName stringByAppendingString:@"_background.png"];
    [self.backgroundImage setImage:[UIImage imageNamed:imageName]];
    
    
    NSLog(@"!!zodiacName %@",zodiacName);
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:zodiacName withExtension:@"gif"];

    

    _gifView = [[SvGifView alloc] initWithCenter:CGPointMake(160, 274) fileURL:fileUrl];
    _gifView.backgroundColor = [UIColor clearColor];
    _gifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:_gifView];
    [_gifView release];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_gifView startGif];
    [self performSelector:@selector(jumpToNext) withObject:[UIColor blueColor]afterDelay:4];
}
-(void)jumpToNext
{
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *dViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"ScratchView"];
    
    dViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//页面切换效果设置
    [self presentModalViewController: dViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startGif
{
    [_gifView startGif];
}

- (void)stopGif
{
    [_gifView stopGif];
}

@end
