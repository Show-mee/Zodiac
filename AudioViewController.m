//
//  AudioViewController.m
//  ChineseWheel
//
//  Created by GraceXu on 14/04/15.
//
//

#import "AudioViewController.h"
#import "IFlyMSC/IFlyMSC.h"

#import "ISEResult.h"
#import "ISEResultXmlParser.h"
#import "ViewUIPrefix.h"
#import "PopupView.h"
#import "ISEParams.h"
#import "ISESettingViewController.h"

#pragma mark - const values

NSString* const KCIseViewControllerTitle=@"语音评测";
NSString* const KCIseHideBtnTitle=@"隐藏";
NSString* const KCIseSettingBtnTitle=@"设置";
NSString* const KCIseStartBtnTitle=@"开始评测";
NSString* const KCIseStopBtnTitle=@"停止评测";
NSString* const KCIseParseBtnTitle=@"结果解析";
NSString* const KCIseCancelBtnTitle=@"取消评测";

NSString* const KCTextCNSyllable=@"text_cn_syllable";
NSString* const KCTextCNWord=@"text_cn_word";
NSString* const KCTextCNSentence=@"text_cn_sentence";
NSString* const KCTextENWord=@"text_en_word";
NSString* const KCTextENSentence=@"text_en_sentence";

NSString* const KCResultNotify1=@"请点击“开始评测”按钮";
NSString* const KCResultNotify2=@"请朗读以上内容";
NSString* const KCResultNotify3=@"停止评测，结果等待中...";




@interface AudioViewController ()<IFlySpeechEvaluatorDelegate ,ISESettingDelegate ,ISEResultXmlParserDelegate>

@property (strong, nonatomic) IBOutlet UIButton *imageView;



@property (retain, nonatomic) AVAudioPlayer *avPlay;

@property (weak, nonatomic) IBOutlet UIImageView *background;

//view
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) CGFloat textViewHeight;
@property (nonatomic, strong) UITextView *resultView;
@property (nonatomic, strong) NSString* resultText;
@property (nonatomic, assign) CGFloat resultViewHeight;

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *stopBtn;
@property (nonatomic, strong) UIButton *parseBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) PopupView *popupView;
@property (nonatomic, strong) ISESettingViewController *settingViewCtrl;



//  about the evaluator
@property (nonatomic, strong) IFlySpeechEvaluator *iFlySpeechEvaluator;
@property (nonatomic, assign) BOOL isSessionResultAppear;
@property (nonatomic, assign) BOOL isSessionEnd;
@property (nonatomic, assign) BOOL isValidInput;

@end

@implementation AudioViewController

- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _background.image = [UIImage imageNamed:@"07background"];
    [self audio];
    [self.imageView addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [self.imageView addTarget:self action:@selector(btnUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragExit];
//    [self.playBtn addTarget:self action:@selector(playRecordSound:) forControlEvents:UIControlEventTouchDown];
    
    
    	if (!self.iFlySpeechEvaluator) {
    		self.iFlySpeechEvaluator = [IFlySpeechEvaluator sharedInstance];
    	}
    	self.iFlySpeechEvaluator.delegate = self;
    	//清空参数，目的是评测和听写的参数采用相同数据
    	[self.iFlySpeechEvaluator setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        self.iseParams=[ISEParams fromUserDefaults];
        [self reloadCategoryText];
    
}

//-(void)reloadCategoryText{
//
//    [self.iFlySpeechEvaluator setParameter:self.iseParams.bos forKey:[IFlySpeechConstant VAD_BOS]];
//    [self.iFlySpeechEvaluator setParameter:self.iseParams.eos forKey:[IFlySpeechConstant VAD_EOS]];
//    [self.iFlySpeechEvaluator setParameter:self.iseParams.category forKey:[IFlySpeechConstant ISE_CATEGORY]];
//    [self.iFlySpeechEvaluator setParameter:self.iseParams.language forKey:[IFlySpeechConstant LANGUAGE]];
//    [self.iFlySpeechEvaluator setParameter:self.iseParams.rstLevel forKey:[IFlySpeechConstant ISE_RESULT_LEVEL]];
//    [self.iFlySpeechEvaluator setParameter:self.iseParams.timeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
//
//    if ([self.iseParams.language isEqualToString:KCLanguageZHCN]) {
//        if ([self.iseParams.category isEqualToString:KCCategorySyllable]) {
//            self.textView.text = LocalizedEvaString(KCTextCNSyllable, nil);
//        }
//        else if ([self.iseParams.category isEqualToString:KCCategoryWord]) {
//            self.textView.text = LocalizedEvaString(KCTextCNWord, nil);
//        }
//        else {
//            self.textView.text = LocalizedEvaString(KCTextCNSentence, nil);
//        }
//    }
//    else {
//        if ([self.iseParams.category isEqualToString:KCCategoryWord]) {
//            self.textView.text = LocalizedEvaString(KCTextENWord, nil);
//        }
//        else {
//            self.textView.text = LocalizedEvaString(KCTextENSentence, nil);
//        }
//        self.isValidInput=YES;
//
//    }
//}



- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _iFlySpeechEvaluator = [IFlySpeechEvaluator sharedInstance];
    _iFlySpeechEvaluator.delegate = self;
    
    //清空参数
    [_iFlySpeechEvaluator setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    
    _isSessionResultAppear=YES;
    _isSessionEnd=YES;
    _isValidInput=YES;
    
    return self;
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)jumpToWheel:(id)sender {
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self presentModalViewController:[secondStoryboard instantiateViewControllerWithIdentifier:@"FirstView"] animated:YES];
}


- (IBAction)jumpBack:(id)sender {
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self presentModalViewController:[secondStoryboard instantiateViewControllerWithIdentifier:@"ScatchView"] animated:YES];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)playRecordSound:(id)sender
{
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:recorder.url error:nil];
    self.avPlay = player;
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

/*!
 *  设置界面加载
 */
- (void)loadView {
    [super loadView];
    
    // adjust the UI for iOS 7
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IOS7_OR_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
#endif
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIView *mainView = [[UIView alloc] initWithFrame:frame];
    mainView.backgroundColor = [UIColor whiteColor];
    self.view = mainView;
    self.title = KCIseViewControllerTitle;
    
    int textViewHeight = self.view.frame.size.height - _DEMO_UI_BUTTON_HEIGHT * 2 - _DEMO_UI_MARGIN * 10 - _DEMO_UI_NAVIGATIONBAR_HEIGHT;
    
    //textView
    UITextView *textView = [[UITextView alloc] initWithFrame:
                            CGRectMake(_DEMO_UI_MARGIN * 2,
                                       _DEMO_UI_MARGIN * 2,
                                       self.view.frame.size.width - _DEMO_UI_MARGIN * 4,
                                       textViewHeight / 2)];
    textView.layer.cornerRadius = 8;
    textView.layer.borderWidth = 1;
    textView.text = @"";
    textView.font = [UIFont systemFontOfSize:17.0f];
    textView.pagingEnabled = YES;
    
    UIEdgeInsets edgeInsets = [textView contentInset];
    edgeInsets.left = 10;
    edgeInsets.right = 10;
    edgeInsets.top = 10;
    edgeInsets.bottom = 10;
    textView.contentInset = edgeInsets;
    [textView setEditable:YES];
    self.textView = textView;
    self.textViewHeight=self.textView.frame.size.height;
    [self.view addSubview:textView];
    
    //resultView
    UITextView *resultView = [[UITextView alloc] initWithFrame:
                              CGRectMake(_DEMO_UI_MARGIN * 2,
                                         textView.frame.size.height + _DEMO_UI_MARGIN * 3,
                                         self.view.frame.size.width - _DEMO_UI_MARGIN * 4,
                                         textViewHeight / 2)];
    resultView.layer.cornerRadius = 8;
    resultView.layer.borderWidth = 1;
    resultView.text = @"";
    resultView.font = [UIFont systemFontOfSize:17.0f];
    resultView.pagingEnabled = YES;
    
    resultView.contentInset = edgeInsets;
    [resultView setEditable:NO];
    self.resultView = resultView;
    self.resultView.text =KCResultNotify1;
    self.resultViewHeight=self.resultView.frame.size.height;
    [self.view addSubview:resultView];
    
    //键盘工具栏
    UIBarButtonItem *spaceBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:nil
                                                                                  action:nil];
    UIBarButtonItem *hideBtnItem = [[UIBarButtonItem alloc] initWithTitle:KCIseHideBtnTitle
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(onKeyBoardDown:)];
    [hideBtnItem setTintColor:[UIColor whiteColor]];
    UIToolbar *keyboardToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _DEMO_UI_TOOLBAR_HEIGHT)];
    keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
    NSArray *array = [NSArray arrayWithObjects:spaceBtnItem, hideBtnItem, nil];
    [keyboardToolbar setItems:array];
    textView.inputAccessoryView = keyboardToolbar;
    textView.textAlignment = IFLY_ALIGN_LEFT;
    
    
    //开始
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startBtn setTitle:KCIseStartBtnTitle forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(_DEMO_UI_MARGIN * 2,
                                resultView.frame.origin.y + resultView.frame.size.height + _DEMO_UI_MARGIN,
                                (self.view.frame.size.width - _DEMO_UI_PADDING * 3) / 2,
                                _DEMO_UI_BUTTON_HEIGHT);
    
    [startBtn addTarget:self action:@selector(onBtnStart:) forControlEvents:UIControlEventTouchUpInside];
    self.startBtn = startBtn;
    [self.view addSubview:startBtn];
    
    UIButton *parseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [parseBtn setTitle:KCIseParseBtnTitle forState:UIControlStateNormal];
    parseBtn.frame = CGRectMake(startBtn.frame.origin.x + _DEMO_UI_PADDING + startBtn.frame.size.width,
                                resultView.frame.origin.y + resultView.frame.size.height + _DEMO_UI_MARGIN,
                                startBtn.frame.size.width,
                                startBtn.frame.size.height);
    
    [parseBtn addTarget:self action:@selector(onBtnParse:) forControlEvents:UIControlEventTouchUpInside];
    self.parseBtn = parseBtn;
    [self.view addSubview:parseBtn];
    
    //停止
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stopBtn setTitle:KCIseStopBtnTitle forState:UIControlStateNormal];
    stopBtn.frame = CGRectMake(_DEMO_UI_PADDING,
                               startBtn.frame.origin.y + startBtn.frame.size.height + _DEMO_UI_MARGIN,
                               (self.view.frame.size.width - _DEMO_UI_PADDING * 3) / 2,
                               _DEMO_UI_BUTTON_HEIGHT);
    [stopBtn addTarget:self action:@selector(onBtnStop:) forControlEvents:UIControlEventTouchUpInside];
    self.stopBtn = stopBtn;
    [self.view addSubview:stopBtn];
    
    
    //取消
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelBtn setTitle:KCIseCancelBtnTitle forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(stopBtn.frame.origin.x + _DEMO_UI_PADDING + stopBtn.frame.size.width,
                                 stopBtn.frame.origin.y,
                                 stopBtn.frame.size.width,
                                 stopBtn.frame.size.height);
    [cancelBtn addTarget:self action:@selector(onBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn = cancelBtn;
    [self.view addSubview:cancelBtn];
    
    //popupView
    self.popupView = [[PopupView alloc]initWithFrame:CGRectMake(100, 300, 0, 0)];
    self.popupView.ParentView = self.view;
    
//    //SettingView
//    UIBarButtonItem *settingBtn = [[UIBarButtonItem alloc] initWithTitle:KCIseSettingBtnTitle
//                                                                   style:UIBarButtonItemStylePlain
//                                                                  target:self
//                                                                  action:@selector(onSetting:)];
//    self.navigationItem.rightBarButtonItem = settingBtn;
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
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
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
        [self.imageView setBackgroundImage:[UIImage imageNamed:@"record_animate_01.png"] forState:UIControlStateNormal];
    }else if (0.06<lowPassResults<=0.13) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_02.png"] forState:UIControlStateNormal];
    }else if (0.13<lowPassResults<=0.20) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_03.png"] forState:UIControlStateNormal];
    }else if (0.20<lowPassResults<=0.27) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_04.png"] forState:UIControlStateNormal];
    }else if (0.27<lowPassResults<=0.34) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_05.png"] forState:UIControlStateNormal];
    }else if (0.34<lowPassResults<=0.41) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_06.png"] forState:UIControlStateNormal];
    }else if (0.41<lowPassResults<=0.48) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_07.png"] forState:UIControlStateNormal];
    }else if (0.48<lowPassResults<=0.55) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_08.png"] forState:UIControlStateNormal];
    }else if (0.55<lowPassResults<=0.62) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_09.png"] forState:UIControlStateNormal];
    }else if (0.62<lowPassResults<=0.69) {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_10.png"] forState:UIControlStateNormal];

    }else {
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_11.png"] forState:UIControlStateNormal];

    }
}

- (void) updateImage
{
        [self.imageView setImage:[UIImage imageNamed:@"record_animate_01.png"] forState:UIControlStateNormal];
}






@end
