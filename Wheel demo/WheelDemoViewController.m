#import "WheelDemoViewController.h"
#import "CDCircleOverlayView.h"
#import "PopupView.h"

@interface WheelDemoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *background;
@property (nonatomic) int x,y;
@property (nonatomic) int c1, c2, c3, c4;
@property (nonatomic, strong) UILabel* name;
@property (nonatomic, strong) PopupView *popupView;
@property(nonatomic, strong) UIButton * startBtn;
@property (nonatomic) int seg;



@end

@implementation WheelDemoViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    
    CGPoint point = [touch locationInView: self.view]; //返回触摸点在视图中的当前坐标
    self.x = point.x;
    self.y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", self.x, self.y);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CDCircle *CircleGo = [[CDCircle alloc] initWithFrame:CGRectMake(XcircleGo, YcircleGo, circleGo, circleGo) numberOfSegments:12 ringWidth:ringGo numOfLevel:0];
    CircleGo.dataSource = self;
    CircleGo.delegate = self;
    CDCircleOverlayView *OverlayGo = [[CDCircleOverlayView alloc] initWithCircle:CircleGo];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    self.view.backgroundColor = background;
    
    
    [self.view addSubview:CircleGo];
    CircleGo.tag = 17; //you can use any number you like
    OverlayGo.tag = 18;
    [self.view addSubview:CircleGo];
    [self.view addSubview:OverlayGo];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"confirmBtn"] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"" forState:UIControlStateNormal];
    //    startBtn.bounds = CGRectMake(160, 274, 320,290);
    confirmBtn.frame = CGRectMake(100, 500, 130, 44);
    
    [confirmBtn addTarget:self action:@selector(onBtnWheel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}


- (void) onBtnWheel:(id) sender{
    
    //    [self.view setHidden:YES];
    zodiacName =   [NSString stringWithFormat:@"%d", (self.seg+1)];
    NSLog(zodiacName);

    [self.background setImage: [UIImage imageNamed: @"bgBlack.png"]];
    UIView *RemoveCircleGo = [self.view viewWithTag:17];
    UIView *RemoveOverlayGo = [self.view viewWithTag:18];
    [RemoveCircleGo removeFromSuperview];
    [RemoveOverlayGo removeFromSuperview];
    
    CDCircle *firstCircle = [[CDCircle alloc] initWithFrame:CGRectMake(XcircleOne , YcircleOne, circleOne, circleOne) numberOfSegments:12 ringWidth:ringOne numOfLevel:1];
    firstCircle.dataSource = self;
    firstCircle.delegate = self;
    CDCircleOverlayView *firstOverlay = [[CDCircleOverlayView alloc] initWithCircle:firstCircle];
    
    
    CDCircle *secondCircle = [[CDCircle alloc] initWithFrame:CGRectMake(XcircleTwo , YcircleTwo, circleTwo, circleTwo) numberOfSegments:12 ringWidth:ringTwo numOfLevel:2];
    secondCircle.dataSource = self;
    secondCircle.delegate = self;
    CDCircleOverlayView *secondOverlay = [[CDCircleOverlayView alloc] initWithCircle:secondCircle];
    
    
    CDCircle *thirdCircle = [[CDCircle alloc] initWithFrame:CGRectMake(XcircleThree , YcircleThree, circleThree, circleThree) numberOfSegments:12 ringWidth:ringThree numOfLevel:3];
    thirdCircle.dataSource = self;
    thirdCircle.delegate = self;
    CDCircleOverlayView *thirdOverlay = [[CDCircleOverlayView alloc] initWithCircle:thirdCircle];
    
    CDCircle *fourthCircle = [[CDCircle alloc] initWithFrame:CGRectMake(XcircleFour , YcircleFour, circleFour, circleFour) numberOfSegments:12 ringWidth:ringFour numOfLevel:4];
    fourthCircle.dataSource = self;
    fourthCircle.delegate = self;
    CDCircleOverlayView *fourthOverlay = [[CDCircleOverlayView alloc] initWithCircle:fourthCircle];
    
    self.view.backgroundColor = [UIColor colorWithRed:133/255.0f green:121/255.0f blue:79/255.0f alpha:1.0f];
    
    
    [self.view addSubview:fourthCircle];
    [self.view addSubview:fourthOverlay];
    
    [self.view addSubview:thirdCircle];
    [self.view addSubview:thirdOverlay];
    
    [self.view addSubview:secondCircle];
    [self.view addSubview:secondOverlay];
    
    [self.view addSubview:firstCircle];
    [self.view addSubview:firstOverlay];
    
    _startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _startBtn.frame = CGRectMake(94, 200, 144, 73);

    [self.startBtn setBackgroundImage:[UIImage imageNamed:@"startBtn"] forState:UIControlStateNormal];
    [_startBtn setTitle:@"" forState:UIControlStateNormal];
    self.startBtn.hidden = true;
    [self.startBtn addTarget:self action:@selector(onBtnStart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startBtn];
    
}
//Changed

- (void) onBtnStart:(id) sender
{
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *dViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"GIFoverview"];
    
    dViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//页面切换效果设置
    
    [self presentModalViewController: dViewController animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Circle delegate & data source

-(void) circle:(CDCircle *)circle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    
    NSString *word = @"" ;
    if(segment == 0){
        word = @"Shu/Mouse";
    }if(segment == 1){
        word = @"Niu";
    }if(segment == 2){
        word = @"Hu/Tiger";
    }if(segment == 3){
        word = @"Tu/Rabbit";
    }if(segment == 4){
        word = @"Long/Dragon";
    }if(segment == 5){
        word = @"She/Snake";
    }if(segment == 6){
        word = @"Ma/Horse";
    }if(segment == 7){
        word = @"Yang/Sheep";
    }if(segment == 8){
        word = @"Hou/Monkey";
    }if(segment == 9){
        word = @"Ji/Chicken";
    }if(segment == 10){
        word = @"Gou/Dog";
    }if(segment == 11){
        word = @"Zhu/Pig";
    }

//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User did select item" message:[NSString stringWithFormat:@"Your choice is: %@", word] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert show];
    
    //Change the label
    
    //record the circle number
    if(460 <= self.y){
        self.c1 = segment;
         NSLog(@"c1: %d",self.c1 );
    }else if(320<=self.y && self.y<460){
        self.c2 = segment;
         NSLog(@"c2: %d",self.c2 );
    } else if(180<=self.y && self.y<320){
        self.c3 = segment;
        NSLog(@"c3: %d",self.c3 );
    }else{
        self.c4 = segment;
         NSLog(@"c4: %d",self.c4 );
    }
    self.seg = segment;

    
    if(self.c1 == self.c2 && self.c2 == self.c3 && self.c3 == self.c4 && self.c3 == ([zodiacName intValue] - 1)){
        
//        popupView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat: @"Congratulations! You got a %@",word] message:@"Let's go to writing part" delegate:nil cancelButtonTitle:@"nil" otherButtonTitles: nil];
//        [alert show];
//        int zo = segment + 1;
//        zodiacName = [NSString stringWithFormat:@"%d", zo];
//        self.seg = [NSString stringWithFormat:@"%d", zo];

        self.popupView = [[PopupView alloc]initWithFrame:CGRectMake(200, 300, 289, 147)];
        self.popupView.ParentView = self.view;
        [self.popupView setText:[NSString stringWithFormat:@"You got a %@", word]];
        
        [self.view addSubview:self.popupView];
        self.startBtn.hidden = false;
        
//        [self.popupView setText:[NSString stringWithFormat:@"Let's go to the writing part"]];
//        [self.view addSubview:self.popupView];
        
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat: @"Congratulations! You got a %@",word] message:@"Let's go to writing part" delegate:nil cancelButtonTitle:@"nil" otherButtonTitles: nil];
//                [alert show];


//        [self performSelector:@selector(jumpToGIF) withObject:[UIColor blueColor]afterDelay:2];
        
    }

}

-(void)jumpToGIF
{
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    UIViewController *dViewController = [secondStoryboard instantiateViewControllerWithIdentifier:@"GIFoverview"];
    
    dViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;//页面切换效果设置
    
    [self presentModalViewController: dViewController animated:YES];
    
}

-(UIImage *) circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"C1/."] objectAtIndex:row];
    //    NSLog(@"C1 ROW: %d, FILE: %@", row, fileString);
    return [UIImage imageWithContentsOfFile:fileString];
}

-(UIImage *) secondCircle:(CDCircle *)secondCircle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString2 = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"C2/."] objectAtIndex:row];
    //    NSLog(@"C2 ROW: %d, FILE: %@", row, fileString2);
    return [UIImage imageWithContentsOfFile:fileString2];
}

-(UIImage *) thirdCircle:(CDCircle *)thirdCircle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString3 = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"C3/."] objectAtIndex:row];
    //    NSLog(@"C3 ROW: %d, FILE: %@", row, fileString3);
    return [UIImage imageWithContentsOfFile:fileString3];
}

-(UIImage *) fourthCircle:(CDCircle *)fourthCircle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString4 = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"C4/."] objectAtIndex:row];
    //    NSLog(@"C4 ROW: %d, FILE: %@", row, fileString4);
    return [UIImage imageWithContentsOfFile:fileString4];
}

@end
