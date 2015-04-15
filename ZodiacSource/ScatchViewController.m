//
//  ViewController.m
//  HYScratchCardViewExample
//
//  Created by
//  Copyright (c) 2014Year Shadow. All rights reserved.
//

#import "ScatchViewController.h"
#import "HYScratchCardView.h"
#import "SvGifView.h"
#import "AudioViewController.h"

@interface ScatchViewController ()

@property (nonatomic, strong) HYScratchCardView *scratchCardView;
@property (nonatomic, strong) SvGifView* gifView;
-(BOOL) sendAudioToServer;
- (NSDictionary *) audioRecordingSettings;

@end

@implementation ScatchViewController


@synthesize btn = _btn;
@synthesize imageView = _imageView;
@synthesize playBtn = _playBtn;
@synthesize avPlay = _avPlay;

- (void)viewDidLoad
{
    zodiacName =  @"01";
    // Do any additional setup after loading the view, typically from a nib.
    [self audio];
    [self.btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [self.btn addTarget:self action:@selector(btnUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragExit];
    [self.playBtn addTarget:self action:@selector(playRecordSound:) forControlEvents:UIControlEventTouchDown];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scratchCardView = [[HYScratchCardView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-45)];
    self.scratchCardView.image = [UIImage imageNamed:@"horseScatched"];
    [self.view addSubview:self.scratchCardView];
    
    self.scratchCardView.completion = ^(id userInfo) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"恭喜"
                                                           message:@"恭喜中奖."
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
        [alertView show];
    };
    [super viewDidLoad];
    
    
    }



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
}
- (IBAction)tipBtn:(id)sender {

    if ([[sender currentTitle] isEqualToString:@"Hide"]) {
        NSLog(@"WEISHA2");

        [sender setTitle:@"Tip" forState:UIControlStateNormal];
        NSLog(@"WEISHA3");
        [_gifView removeFromSuperview];


    }else
    {
        zodiacName = @"02";
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:zodiacName withExtension:@"gif"];
        _gifView = [[SvGifView alloc] initWithCenter:CGPointMake(160, 274) fileURL:fileUrl];
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


- (IBAction)playRecordSound:(id)sender
{
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:recorder.url error:nil];
    self.avPlay = player;
    [player release];
    [self.avPlay play];
}

- (IBAction)btnDown:(id)sender
{
    //创建录音文件，准备录音
    if ([recorder prepareToRecord]) {
        //开始
        [recorder record];
    }
    
    //设置定时检测
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
}
- (IBAction)btnUp:(id)sender
{
    double cTime = recorder.currentTime;
    if (cTime > 1) {//如果录制时间<2 不发送
        NSLog(@"Record Finish");
        //        [self sendAudioToServer];
    }else {
        //删除记录的文件
        [recorder deleteRecording];
        //删除存储的
    }
    [recorder stop];
    //    NSData *data = [NSData dataWithContentsOfURL:recorder.url];
    //    NSLog(@"%@", data);
    [self updateImage];
    [timer invalidate];
}

#pragma mark -
#pragma mark 录音设置


- (NSDictionary *) audioRecordingSettings{
    NSDictionary *result = nil;
    /* Let's prepare the audio recorder options in the dictionary.
     Later we will use this dictionary to instantiate an audio
     recorder of type AVAudioRecorder */
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    
    [settings setValue:[NSNumber numberWithInteger:kAudioFormatLinearPCM]
                forKey:AVFormatIDKey];
    
    [settings setValue:[NSNumber numberWithFloat:16000]
                forKey:AVSampleRateKey];
    
    [settings setValue:[NSNumber numberWithInteger:1]
                forKey:AVNumberOfChannelsKey];
    
    [settings setValue:[NSNumber numberWithInteger:AVAudioQualityLow]
                forKey:AVEncoderAudioQualityKey];
    
    result = [NSDictionary dictionaryWithDictionary:settings];
    return result;
}


- (BOOL) sendAudioToServer
{
    
    //    NSData *myData = [NSData dataWithContentsOfFile:[recorder.url absoluteString]];
    NSLog(@"%@",recorder.url);
    NSData *myData = [NSData dataWithContentsOfFile:[recorder.url path]];
    //    NSLog(@"%@",myData);
    
    //NSString *audio = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/recordTest.flac", recDir]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://www.google.com/speech-api/v2/recognize?output=json&lang=zh-CN&key=AIzaSyAWXF5RWG-BQCJrbwYqUfzwx6DpRUPZ7vE"]];
    
    [request setHTTPMethod:@"POST"];
    
    //set headers
    
    [request addValue:@"Content-Type" forHTTPHeaderField:@"audio/L16; rate=16000"];
    
    [request addValue:@"audio/L16; rate=16000" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:myData];
    
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[myData length]] forHTTPHeaderField:@"Content-length"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"The answer is: %@",result);
    
    
    
    
    
    
    return YES;
}

- (IBAction)btnDragUp:(id)sender
{
    //删除录制文件
    [recorder deleteRecording];
    [recorder stop];
    [timer invalidate];
    
    NSLog(@"取消发送");
}
- (void)audio
{
    //录音设置
    NSMutableDictionary *recordSetting = [[[NSMutableDictionary alloc]init] autorelease];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.wav", strUrl]];
    
    
    NSError *error;
    
    //初始化
    
    recorder = [[AVAudioRecorder alloc]initWithURL:url settings:[self audioRecordingSettings] error:&error];
    //开启音量检测
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
}

- (void)detectionVoice
{
    [recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    NSLog(@"%lf",lowPassResults);
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.06) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
    }else if (0.06<lowPassResults<=0.13) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_02.png"]];
    }else if (0.13<lowPassResults<=0.20) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_03.png"]];
    }else if (0.20<lowPassResults<=0.27) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_04.png"]];
    }else if (0.27<lowPassResults<=0.34) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_05.png"]];
    }else if (0.34<lowPassResults<=0.41) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_06.png"]];
    }else if (0.41<lowPassResults<=0.48) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_07.png"]];
    }else if (0.48<lowPassResults<=0.55) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_08.png"]];
    }else if (0.55<lowPassResults<=0.62) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_09.png"]];
    }else if (0.62<lowPassResults<=0.69) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_10.png"]];
    }else if (0.69<lowPassResults<=0.76) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_11.png"]];
    }else if (0.76<lowPassResults<=0.83) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_12.png"]];
    }else if (0.83<lowPassResults<=0.9) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_13.png"]];
    }else {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_14.png"]];
    }
}

- (void) updateImage
{
    [self.imageView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
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



