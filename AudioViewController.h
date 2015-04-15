//
//  AudioViewController.h
//  ChineseWheel
//
//  Created by GraceXu on 15/04/15.
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
    
}

@property (nonatomic, strong) ISEParams *iseParams;

@end

