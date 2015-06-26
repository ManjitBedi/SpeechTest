//
//  NOViewController.h
//  SpeechTest
//
//  Created by Manjit Bedi on 2014-06-02.
//  Copyright (c) 2014 noorg. All rights reserved.
//

// press Home button,
// go back to app, switch off the screen,
// switch on,
// home,
// switch off,
// switch on,
// back to app etc etc,
// you will finally get the problem. No sound at all! (It seems that the sequence to reproduce it, is different all the time, but pressing Home, switch off at random will finally manifest the problem after 2-3 minutes on my iPhone.)

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface NOViewController : UIViewController <AVSpeechSynthesizerDelegate> {
    AVSpeechSynthesizer* _synthesizer;
    NSTimer* _timer;
    BOOL _repeatTimer;
}
@property (weak, nonatomic) IBOutlet UILabel *speechStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *avSessionStatus;
- (IBAction)playJackHandy:(id)sender;
- (IBAction)playHamlet:(id)sender;
- (IBAction)playJackAfterDelay:(id)sender;
- (IBAction)playHamletAfterDelay:(id)sender;
- (IBAction)repeatTimerSwitchValueChanged:(id)sender;


@end
