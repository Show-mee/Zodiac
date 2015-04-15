//
//  AudioViewController.h
//  ChineseWheel
//
//  Created by GraceXu on 14/04/15.
//
//
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@class ISEParams;

@interface AudioViewController : UIViewController<AVAudioRecorderDelegate>
{
    AVAudioRecorder *recorder;
    NSTimer *timer;
    NSURL *urlPlay;
    NSString * zodiacName;
 
    
}
@property (nonatomic, strong) ISEParams *iseParams;


@end
