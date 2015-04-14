//
//  ViewController.h
//  HYScratchCardViewExample
//
//  Created by Shadow on 14-5-26.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioRecorderDelegate>
{
    AVAudioRecorder *recorder;
    NSTimer *timer;
    NSURL *urlPlay;
    NSString * zodiacName;
    
}

@property (retain, nonatomic) IBOutlet UIButton *btn;

@property (retain, nonatomic) IBOutlet UIButton *playBtn;

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) AVAudioPlayer *avPlay;
@end
