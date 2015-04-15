#import "WheelDemoViewController.h"
#import "CDCircleOverlayView.h"

@interface WheelDemoViewController ()

@end

@implementation WheelDemoViewController

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
    [confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    //    startBtn.bounds = CGRectMake(160, 274, 320,290);
    confirmBtn.frame = CGRectMake(100, 500, 100, 100);
    
    [confirmBtn addTarget:self action:@selector(onBtnWheel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
}


- (void) onBtnWheel:(id) sender{
    
    //    [self.view setHidden:YES];
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
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    //    startBtn.bounds = CGRectMake(160, 274, 320,290);
    startBtn.frame = CGRectMake(100, 100, 100, 100);
    
    [startBtn addTarget:self action:@selector(onBtnStart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
}

- (void) onBtnStart:(id) sender
{
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    zodiacName = @"07";
    [self presentModalViewController:[secondStoryboard instantiateViewControllerWithIdentifier:@"GIFoverview"] animated:YES];
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User did select item" message:[NSString stringWithFormat:@"Your choice is: %@", word] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
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
