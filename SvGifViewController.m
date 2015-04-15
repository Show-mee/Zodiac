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
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(0, 0, 100, 60);
//    btn.center = CGPointMake(100, self.view.bounds.size.height - 50);
//    btn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    [btn setTitle:@"Learn" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(startGif) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn2.frame = CGRectMake(0, 0, 100, 60);
//    btn2.center = CGPointMake(220, self.view.bounds.size.height - 50);
//    btn2.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//    [btn2 setTitle:@"Practise" forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(stopGif) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn2];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_gifView startGif];
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
