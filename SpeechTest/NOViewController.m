//
//  NOViewController.m
//  SpeechTest
//
//  Created by Manjit Bedi on 2014-06-02.
//  Copyright (c) 2014 noorg. All rights reserved.
//

NSString *hamlet =

@"To be, or not to be--that is the question:"
"Whether 'tis nobler in the mind to suffer"
"The slings and arrows of outrageous fortune"
"Or to take arms against a sea of troubles"
"And by opposing end them. To die, to sleep--"
"No more--and by a sleep to say we end"
"The heartache, and the thousand natural shocks"
"That flesh is heir to. 'Tis a consummation"
"Devoutly to be wished. To die, to sleep--"
"To sleep--perchance to dream: ay, there's the rub,"
"For in that sleep of death what dreams may come"
"When we have shuffled off this mortal coil,"
"Must give us pause. There's the respect"
"That makes calamity of so long life."
"For who would bear the whips and scorns of time,"
"Th' oppressor's wrong, the proud man's contumely"
"The pangs of despised love, the law's delay,"
"The insolence of office, and the spurns"
"That patient merit of th' unworthy takes,"
"When he himself might his quietus make"
"With a bare bodkin? Who would fardels bear,"
"To grunt and sweat under a weary life,"
"But that the dread of something after death,"
"The undiscovered country, from whose bourn"
"No traveller returns, puzzles the will,"
"And makes us rather bear those ills we have"
"Than fly to others that we know not of?"
"Thus conscience does make cowards of us all,"
"And thus the native hue of resolution"
"Is sicklied o'er with the pale cast of thought,"
"And enterprise of great pitch and moment"
"With this regard their currents turn awry"
"And lose the name of action. -- Soft you now,"
"The fair Ophelia! -- Nymph, in thy orisons"
"Be all my sins remembered.";

NSString *jackHandy = @"Why do people in ship mutinies always ask for \"better treatment\"? I'd ask for a pinball machine, because with all that rocking back and forth you'd probably be able to get a lot of free games.";


#import "NOViewController.h"

@interface NOViewController ()

@end

@implementation NOViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSError *error;
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:&error];
//    if(error){
//        _avSessionStatus.text = [error localizedDescription];
//    }
//
//    [[AVAudioSession sharedInstance] setActive:YES error:&error];
//    if(error){
//        _avSessionStatus.text = [error localizedDescription];
//    }
    
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    _synthesizer.delegate = self;
    
    _repeatTimer = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}


- (void)viewDidUnload {
    if(_timer)
        [_timer invalidate];
    
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playJackHandy:(id)sender {
    [self speak:jackHandy];
}


- (IBAction)playHamlet:(id)sender {
    [self speak:hamlet];
}


- (IBAction)playJackAfterDelay:(id)sender {
    NSLog(@"star timer");
    NSDictionary *userInfo = @{ @"speech" : jackHandy };
    _timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(progressTimerFired:) userInfo:userInfo repeats:_repeatTimer];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
}


- (IBAction)playHamletAfterDelay:(id)sender {
    NSLog(@"star timer");
    NSDictionary *userInfo = @{ @"speech" : hamlet };
    _timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(progressTimerFired:) userInfo:userInfo repeats:_repeatTimer];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (IBAction)repeatTimerSwitchValueChanged:(id)sender {
    _repeatTimer = (UISwitch *) sender;
}

#pragma mark -
- (void)appWillEnterForeground:(NSNotification*)aNotification {
    NSLog (@"app will enter foreground");
}


- (void)appDidEnterBackground:(NSNotification*)aNotification {
    NSLog (@"app did enter background");
}


#pragma mark -
- (void) speak:(NSString *) speechString {
    _speechStatusLabel.text = @"start speech";
    AVSpeechUtterance *utterance1 = [[AVSpeechUtterance alloc] initWithString:speechString];
    [self initUtterance:utterance1];
    [_synthesizer speakUtterance:utterance1];
}


- (void) progressTimerFired:(NSTimer *)timer {
    NSLog(@"timer event fired");
    NSDictionary *userInfo = timer.userInfo;
    NSString *speechString = userInfo[@"speech"];
    [self speak:speechString];
}


- (void)initUtterance:(AVSpeechUtterance*)utterance {
    AVSpeechSynthesisVoice* voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    utterance.rate = 0.1f;
    utterance.volume = 1.0;
    utterance.voice = voice;
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"start speech utterance");
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"speech utterance finished");
    _speechStatusLabel.text = @"speech utterance finished";
}


@end
