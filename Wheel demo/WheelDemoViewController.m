#import "WheelDemoViewController.h"
#import "CDCircleOverlayView.h"


#define circleOne 560
#define XcircleOne -120
#define YcircleOne 458
#define ringOne 140.f


#define circleTwo 841
#define XcircleTwo -260.5
#define YcircleTwo 318
#define ringTwo 140.f


#define circleThree 1122
#define XcircleThree -401
#define YcircleThree 178
#define ringThree 140.f

#define circleFour 1402
#define XcircleFour -541
#define YcircleFour 38.5
#define ringFour 140.f

@interface WheelDemoViewController ()

@end

@implementation WheelDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //Set this property to change color of the overlay thumb (by default it's light gray with alpha set to 0.3f
    
//     circle.overlayView.overlayThumb.arcColor = [UIColor colorWithRed:0.00f green:1.00f blue:0.25f alpha:0.3];
//    circle.overlayView.overlayThumb.arcColor = [UIColor colorWithRed:98/255.0f green:29/255.0f blue:29/255.0f alpha:0.3f];
    
    //Set this property to change color of a circle. It may be usable when you want to achieve specyfic effect (e.g. semi transparent thumbs, and coloured circle will create some effect
    
//     circle.circleColor = [UIColor blackColor];
//    firstCircle.circleColor = [UIColor colorWithRed:98/255.0f green:29/255.0f blue:29/255.0f alpha:0.3f];
    
//    secondCircle.circleColor = [UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:0.3f];
    
//    thirdCircle.circleColor = [UIColor colorWithRed:100/255.0f green:100/255.0f blue:100/255.0f alpha:0.3f];
    
    
    //To modify single thumb, take it's pointer as follows "[circle.thumbs objectAtIndex:x];" and then  you can set it's properties
    
    
    /*
     
     CDCircleThumb *thumb = [circle.thumbs objectAtIndex:0];
     
     
     //Color of a highlited icon on thumb
     [thumb.iconView setHighlitedIconColor:[UIColor blueColor]];
     //Color of the separator
     thumb.separatorColor = [UIColor redColor];
     //Separator style may be basic and None
     thumb.separatorStyle = CDCircleThumbsSeparatorNone;
     //If gradientFill is set to NO, a thumb is coloured with solid color
     thumb.gradientFill = YES;
     //Colors of a gradient
     thumb.gradientColors = [NSArray arrayWithObjects:(id) [UIColor whiteColor].CGColor, (id) [UIColor yellowColor].CGColor, (id) [UIColor cyanColor].CGColor, nil];
     //If you omit locations of colors, colors will be placed symmetrical
     thumb.colorsLocations = [NSMutableArray arrayWithObjects:[NSNumber numberWithFloat:0.00f], [NSNumber numberWithFloat:0.30f], [NSNumber numberWithFloat:1.00f], nil];
     
     
     */
    
    
    
    
//    To modify all thumbs, simply iterate through them and change their properties.
    /*
     for (CDCircleThumb *thumb in circle.thumbs) {
     [thumb.iconView setHighlitedIconColor:[UIColor redColor]];
     thumb.separatorColor = [UIColor blackColor];
     thumb.separatorStyle = CDCircleThumbsSeparatorBasic;
     thumb.gradientFill = NO;
     thumb.arcColor = [UIColor redColor];
     thumb.gradientColors = [NSArray arrayWithObjects:(id) [UIColor blackColor].CGColor, (id) [UIColor yellowColor].CGColor, (id) [UIColor blueColor].CGColor, nil];
     thumb.colorsLocations = [NSMutableArray arrayWithObjects:[NSNumber numberWithFloat:0.00f], [NSNumber numberWithFloat:0.30f], [NSNumber numberWithFloat:1.00f], nil];
     
     }
     */
    
    [self.view addSubview:fourthCircle];
    [self.view addSubview:fourthOverlay];
    
    [self.view addSubview:thirdCircle];
    [self.view addSubview:thirdOverlay];
    
    [self.view addSubview:secondCircle];
    [self.view addSubview:secondOverlay];
    
    [self.view addSubview:firstCircle];
    [self.view addSubview:firstOverlay];
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
}

-(void) secondCircle:(CDCircle *)secondCircle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    
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
}

-(void) thirdCircle:(CDCircle *)thirdCircle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    
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
}


-(void) fourthCircle:(CDCircle *)fourthCircle didMoveToSegment:(NSInteger)segment thumb:(CDCircleThumb *)thumb {
    
    NSString *word = @"" ;
    if(segment == 0){
        word = @"Shu/Mouse";
    }if(segment == 1){
        word = @"Niu/Ox";
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
    
    if (thumb == 1) {

    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User did select item" message:[NSString stringWithFormat:@"Your choice is: %@", word] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(UIImage *) circle:(CDCircle *)circle iconForThumbAtRow:(NSInteger)row {

    NSString *fileString = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"C1/."] objectAtIndex:row];
    
    NSLog(@"C1 ROW: %d, FILE: %@", row, fileString);
    
    return [UIImage imageWithContentsOfFile:fileString];
    
}

-(UIImage *) secondCircle:(CDCircle *)secondCircle iconForThumbAtRow:(NSInteger)row {
    
    NSString *fileString2 = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"C2/."] objectAtIndex:row];
    
    NSLog(@"C2 ROW: %d, FILE: %@", row, fileString2);
    
    return [UIImage imageWithContentsOfFile:fileString2];
    
}

-(UIImage *) thirdCircle:(CDCircle *)thirdCircle iconForThumbAtRow:(NSInteger)row {
    
    NSString *fileString3 = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"C3/."] objectAtIndex:row];
    
    NSLog(@"C3 ROW: %d, FILE: %@", row, fileString3);
    
    return [UIImage imageWithContentsOfFile:fileString3];
    
}

-(UIImage *) fourthCircle:(CDCircle *)fourthCircle iconForThumbAtRow:(NSInteger)row {
    NSString *fileString4 = [[[NSBundle mainBundle] pathsForResourcesOfType:@"png" inDirectory:@"C4/."] objectAtIndex:row];
    
    NSLog(@"C4 ROW: %d, FILE: %@", row, fileString4);
    
    return [UIImage imageWithContentsOfFile:fileString4];
    
}



@end
