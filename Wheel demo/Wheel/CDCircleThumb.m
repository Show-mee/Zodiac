#define kIconViewWidth 60
#define kIconViewHeight 80

#import <QuartzCore/QuartzCore.h>

#import "Common.h"
#import "CDCircleThumb.h"

@implementation CDCircleThumb
@synthesize sRadius, lRadius, yydifference, arc, separatorColor, separatorStyle, centerPoint;
@synthesize iconView;
@synthesize gradientFill, gradientColors, arcColor;
@synthesize colorsLocations;
- (id)initWithShortCircleRadius:(CGFloat)shortRadius longRadius:(CGFloat)longRadius numberOfSegments: (CGFloat) sNumber

{
    //Calculating suitable frame
        //Variables
    
    CGRect frame;
    
    CGFloat width;
    CGFloat height;
    //
    CGFloat fstartAngle = 270 - ((360/sNumber)/2);
    CGFloat fendAngle = 270 + ((360/sNumber)/2);
    //
    CGFloat startAngle = degreesToRadians(fstartAngle);
    CGFloat endAngle = degreesToRadians(fendAngle);
    
    
    UIBezierPath *bigArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(longRadius, longRadius) radius:longRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    UIBezierPath *smallArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(longRadius, longRadius) radius:shortRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
            // Start of calculations
    if ((fendAngle - fstartAngle) <= 180) {
            width = bigArc.bounds.size.width;
        height = smallArc.currentPoint.y ;
        frame = CGRectMake(0, 0, width, height);
    }
    if ((fendAngle - fstartAngle) > 269) {
        frame = CGRectMake(0, 0, bigArc.bounds.size.width, bigArc.bounds.size.height);
    }
            //End of calculations
    
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        sRadius = shortRadius;
        lRadius = longRadius;
        numberOfSegments = sNumber;
        CGFloat y = (lRadius - sRadius)/2.00;
        CGFloat xi = 0.5;
        CGFloat yi = y/frame.size.height;
        self.layer.anchorPoint = CGPointMake(xi, yi);
//        self.gradientFill = NO;
        
        self.arcColor = [UIColor colorWithRed:98/255.0f green:29/255.0f blue:29/255.0f alpha:1.0f];
        
        self.centerPoint = CGPointMake(CGRectGetMidX(self.bounds), y);
        
        self.iconView = [[CDIconView alloc] initWithFrame:CGRectMake(CGRectGetMidX(frame), y, kIconViewWidth, kIconViewHeight)];
        self.iconView.center = CGPointMake(CGRectGetMidX(frame), y-10);
        
        [self addSubview:self.iconView];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    [self.arcColor setStroke];
    [self.arcColor setFill];
    //Angles
    
    CGFloat clockwiseStartAngle = degreesToRadians((270 - ((360/numberOfSegments)/2)));
    CGFloat clockwiseEndAngle = degreesToRadians((270 + ((360/numberOfSegments)/2)));
    
    CGFloat nonClockwiseStartAngle = clockwiseEndAngle;
    CGFloat nonClockwiseEndAngle = clockwiseStartAngle;
    
    
    
    CGPoint center = CGPointMake(CGRectGetMidX(rect), lRadius);

    self.arc = [UIBezierPath bezierPathWithArcCenter: center radius:lRadius startAngle:clockwiseStartAngle endAngle:clockwiseEndAngle clockwise:YES];
    CGPoint f = arc.currentPoint;
    
        
    [arc addArcWithCenter:center radius:sRadius startAngle:nonClockwiseStartAngle endAngle:nonClockwiseEndAngle clockwise:NO];

    CGPoint e = arc.currentPoint;
    
//    [arc closePath];
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (self.gradientFill == NO) {
        [arc fill];
    }
    
    [[UIColor colorWithRed:133/255.0f green:121/255.0f blue:79/255.0f alpha:1.0f] setStroke];
    [[UIColor colorWithRed:133/255.0f green:121/255.0f blue:79/255.0f alpha:1.0f] setFill];
    
    
    if (self.separatorStyle != CDCircleThumbsSeparatorNone) {
        UIBezierPath *line = [UIBezierPath bezierPath];
        if (separatorStyle == CDCircleThumbsSeparatorBasic) {
            line.lineWidth = 1.0f;
        }
    
    [line moveToPoint:f];
    [line addLineToPoint:CGPointMake(f.x - e.x, e.y)];
    [self.separatorColor setStroke];
    [self.separatorColor setFill];
        
    [line strokeWithBlendMode:kCGBlendModeCopy alpha:1.00f];
    [line fillWithBlendMode:kCGBlendModeCopy alpha:1.00f];
    }
}

-(BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
}

@end
