//
//  ViewController.m
//  HYScratchCardViewExample
//
//  Created by
//  Copyright (c) 2014Year Shadow. All rights reserved.
//

#import "ViewController.h"
#import "HYScratchCardView.h"
#import "SvGifView.h"
#import "AudioViewController.h"
extern NSString* zodiacName;

@interface ViewController ()

@property (nonatomic, strong) HYScratchCardView *scratchCardView;
@property (nonatomic, strong) SvGifView* gifView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;


@end

@implementation ViewController


@synthesize btn = _btn;
@synthesize imageView = _imageView;
@synthesize playBtn = _playBtn;
@synthesize avPlay = _avPlay;

- (void)viewDidLoad
{

    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSString* imageName;
//    = [zodiacName stringByAppendingString:@"_background.png"];
//    [self.backgroundView setImage:[UIImage imageNamed:imageName]];
    
    
    self.scratchCardView = [[HYScratchCardView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-45)];

    imageName = [zodiacName stringByAppendingString:@"_scratched"];
    NSLog(@"zo%@",zodiacName);

    NSLog(@"imageName %@",imageName);
    self.scratchCardView.image = [UIImage imageNamed:imageName];
    [self.view addSubview:self.scratchCardView];
    
    self.scratchCardView.completion = ^(id userInfo) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Contratulations"
                                                           message:@"Let's go to the audio session."
                                                          delegate:nil
                                                 cancelButtonTitle:@"Okay"
                                                 otherButtonTitles:nil];
        [alertView show];
    };
    [super viewDidLoad];
    
    }


- (IBAction)tipBtn:(id)sender {

    if ([[sender currentTitle] isEqualToString:@"Hide"]) {
        NSLog(@"WEISHA2");

        [sender setTitle:@"Tip" forState:UIControlStateNormal];
        NSLog(@"WEISHA3");
        [_gifView removeFromSuperview];


    }else
    {
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:zodiacName withExtension:@"gif"];
        _gifView = [[SvGifView alloc] initWithCenter:CGPointMake(160, 280) fileURL:fileUrl];
        _gifView.backgroundColor = [UIColor clearColor];
        _gifView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [self.view addSubview:_gifView];
        [_gifView release];
        
        [sender setTitle:@"Hide" forState:UIControlStateNormal];

        [_gifView startGif];
    }
}

- (void)startGif
{
    [_gifView startGif];
}

- (void)stopGif
{
    [_gifView stopGif];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)resetButtonClick:(UIButton *)sender {
    [self.scratchCardView reset];
}



- (void)dealloc {
    [_imageView release];
    [_playBtn release];
    [_btn release];
    [super dealloc];
}
@end



