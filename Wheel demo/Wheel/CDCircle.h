#import <UIKit/UIKit.h>

typedef enum {
    CDCircleThumbsSeparatorNone,
    CDCircleThumbsSeparatorBasic
}CDCircleThumbsSeparator;

@class CDCircle, CDCircleThumb, CDCircleOverlayView;
@protocol CDCircleDelegate <NSObject>
@required

-(void) circle: (CDCircle *) circle didMoveToSegment:(NSInteger) segment thumb: (CDCircleThumb *) thumb;

//-(void) secondCircle: (CDCircle *) secondCircle didMoveToSegment:(NSInteger) segment thumb: (CDCircleThumb *) thumb;
//-(void) thirdCircle: (CDCircle *) thirdCircle didMoveToSegment:(NSInteger) segment thumb: (CDCircleThumb *) thumb;
//-(void) fourthCircle: (CDCircle *) fourthCircle didMoveToSegment:(NSInteger) segment thumb: (CDCircleThumb *) thumb;


@end
@protocol CDCircleDataSource <NSObject>
-(UIImage *) circle: (CDCircle *) circle iconForThumbAtRow: (NSInteger) row;
-(UIImage *) secondCircle: (CDCircle *) secondCircle iconForThumbAtRow: (NSInteger) row;
-(UIImage *) thirdCircle: (CDCircle *) thirdCircle iconForThumbAtRow: (NSInteger) row;
-(UIImage *) fourthCircle: (CDCircle *) fourthCircle iconForThumbAtRow: (NSInteger) row;

@end
@class CDCircleGestureRecognizer;

@interface CDCircle : UIView
@property (nonatomic, strong) NSMutableArray *thumbs;
@property (nonatomic, strong) UIBezierPath *circle;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, assign) BOOL inertiaeffect;
@property (nonatomic, strong) CDCircleGestureRecognizer *recognizer;
@property (assign) int numberOfSegments;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CDCircleThumbsSeparator separatorStyle;
@property (nonatomic, strong) CDCircleOverlayView *overlayView;
@property (nonatomic, assign) CGFloat ringWidth;
@property (nonatomic, assign) BOOL overlay;

@property (nonatomic, strong) id <CDCircleDelegate> delegate;
@property (nonatomic, strong) id <CDCircleDataSource> dataSource;

@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic) int numOfLevel;
-(id) initWithFrame:(CGRect)frame numberOfSegments: (NSInteger) nSegments ringWidth: (CGFloat) width numOfLevel:(int)level;

@end