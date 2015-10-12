//
//  PMRecordingViewController.m
//  PeppermintSample
//
//  Created by Sanad on 10/11/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMRecordingViewController.h"
#import "PMLabelButton.h"
#import "PMHelper.h"
#import "UIColor-Expanded.h"
#import "PMPersonRecord.h"
#import "UIView+FLKAutoLayout.h"
#import "PMGlobalConstants.h"

@import AVFoundation;
@import MessageUI;

@interface PMRecordingViewController (){
    PMLabelButton *_pauseButton;
    PMLabelButton *_resumeButton;
    PMLabelButton *_reRecordButton;
    
    UIView *_titleView;
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
    PMPersonRecord *_personRecord;
    AVAudioRecorder *_recorder;
    NSTimer * _recordingTimer;
    NSURL *_outputFileURL;
}

@end

@implementation PMRecordingViewController

- (instancetype)initWithPersonRecord:(PMPersonRecord *)personRecord
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _personRecord = personRecord;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self setupAudioRecorder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _pauseButton = [[PMLabelButton alloc] initWithBaseImageName:@"pause_button" highlightImageName:@"pause_button_pressed" labelText:@"Pause"];
    _pauseButton.delegate = self;
    
    _resumeButton = [[PMLabelButton alloc] initWithBaseImageName:@"play_button" highlightImageName:@"play_button_pressed" labelText:@"Resume"];
    _resumeButton.delegate = self;
    
    _reRecordButton = [[PMLabelButton alloc] initWithBaseImageName:@"re_record_button" highlightImageName:@"re_record_button_pressed" labelText:@"Re-Record"];
    _reRecordButton.delegate = self;
    
    [self.bottomArea addSubview:_resumeButton.view];
    [self.bottomArea addSubview:_pauseButton.view];
    [self.bottomArea addSubview:_reRecordButton.view];
    
    
    [_reRecordButton.view constrainWidthToView:self.bottomArea predicate:@"*.5"];
    [_reRecordButton.view constrainHeightToView:self.bottomArea predicate:nil];
    [_reRecordButton.view alignTopEdgeWithView:self.bottomArea predicate:nil];
    [_reRecordButton.view alignLeadingEdgeWithView:self.bottomArea predicate:nil];
    
    [_resumeButton.view constrainWidthToView:self.bottomArea predicate:@"*.5"];
    [_resumeButton.view constrainHeightToView:self.bottomArea predicate:nil];
    [_resumeButton.view alignTopEdgeWithView:self.bottomArea predicate:nil];
    [_resumeButton.view constrainLeadingSpaceToView:_reRecordButton.view predicate:@"0"];
    
    
    [_pauseButton.view constrainWidthToView:self.bottomArea predicate:@"*.5"];
    [_pauseButton.view constrainHeightToView:self.bottomArea predicate:nil];
    [_pauseButton.view alignTopEdgeWithView:self.bottomArea predicate:nil];
    [_pauseButton.view constrainLeadingSpaceToView:_reRecordButton.view predicate:@"0"];
    
    
    
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [PMHelper appFrameWidth], self.navigationController.navigationBar.frame.size.height)];
    
    _titleLabel = [[UILabel alloc] init];
    _subTitleLabel = [[UILabel alloc] init];
    
    _titleLabel.text = @"Record Message";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:14.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _subTitleLabel.text = [NSString stringWithFormat:@"for %@", _personRecord.fullName];
    _subTitleLabel.textColor = [UIColor colorWithHexString:global_colorGenoa];
    _subTitleLabel.font = [UIFont fontWithName:@"OpenSans-Semibold" size:10.0];
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [_titleView addSubview:_titleLabel];
    [_titleView addSubview:_subTitleLabel];
    
    self.navigationItem.titleView = _titleView;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!_recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        // Start recording
        [_recorder record];
        _recordingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCurrentTimeLabel) userInfo:nil repeats:YES];
        
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    _titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(_titleView.frame), 20);
    _subTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleView.frame), 14);
    
    CGPoint navigationBarCenter = [_titleLabel.superview convertPoint:self.navigationController.navigationBar.center fromView:self.navigationController.navigationBar.superview];
    
    _titleLabel.center = CGPointMake(navigationBarCenter.x, _titleLabel.center.y);
    _subTitleLabel.center = CGPointMake(navigationBarCenter.x, _subTitleLabel.center.y);
}

-(void)updateCurrentTimeLabel{
    int minutes = floor(_recorder.currentTime/60);
    int seconds = round(_recorder.currentTime- minutes * 60);
    
    NSString *time = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    
    self.currentTimeLabel.text =time;
}

-(void)setupAudioRecorder{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-hh-mm-ss"];
    NSString *timeStamp = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *fullName = [[_personRecord.fullName stringByReplacingOccurrencesOfString:@"." withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               [NSString stringWithFormat:@"%@-%@.aac", fullName, timeStamp],
                               nil];
    
    
    _outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    DebugLog(@"outputFileURL: %@", _outputFileURL);
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    NSError* error = nil;
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:_outputFileURL settings:recordSetting error:&error];
    if (error) {
        NSLog(@"Error initializing AVAudioRecorder for file at location %@: %@", _outputFileURL, error);
    }
    
    _recorder.delegate = self;
    [_recorder prepareToRecord];
    
}

- (IBAction)onSendButtonTapped:(id)sender {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (_recorder.recording){
        [_recorder stop];
        [session setActive:NO error:nil];
    }
    
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfURL:_outputFileURL options:0 error:&error];
    NSString *fileName = [NSString stringWithFormat:@"Message-for-%@.aac", _personRecord.fullName];
    if (error) {
        NSLog(@"Unable to load file from provided URL %@: %@", _outputFileURL, error);
    }
    
    if(_personRecord.type == PMRecordTypeEmail){
        //send as email
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
            mailComposer.mailComposeDelegate = self;
            [mailComposer setToRecipients:@[_personRecord.value]];
            [mailComposer setSubject:@"I sent you a voice message"];
            
            [mailComposer setMessageBody:@"<p>Here's my message.</p><p>Reply via <a href='http://peppermint.com'>Peppermint.com</a></p>" isHTML:YES];
            
            
            
            
            [mailComposer addAttachmentData:data mimeType:@"audio/aac"
                                   fileName:fileName];
            
            
            
            mailComposer.modalPresentationStyle = UIModalPresentationFormSheet;
            
            
            
            [self presentViewController:mailComposer animated:YES completion:nil];
        }
    }
    else if (_personRecord.type == PMRecordTypePhone){
        //send as mms
        
        if([MFMessageComposeViewController canSendText]){
            MFMessageComposeViewController *messageComposer = [[MFMessageComposeViewController alloc] init];
            [messageComposer setRecipients:@[_personRecord.value]];
            [messageComposer setBody:@"I sent you a voice message. \n\nReply via www.peppermint.com"];
            messageComposer.messageComposeDelegate = self;
            [self presentViewController:messageComposer animated:YES completion:nil];
            
            if ([MFMessageComposeViewController canSendAttachments]) {
                NSLog(@"Attachments Can Be Sent.");
                BOOL didAttachAudio = [messageComposer addAttachmentData:data typeIdentifier:@"public.mpeg-4-audio" filename:fileName];
                
                if (!didAttachAudio) {
                    NSLog(@"Audio could not be Attached.");
                    
                }
            }
            else{
                NSLog(@"Cannot send attachments");
            }
            
        }
    }
    
}


#pragma mark -- PMLabelButtonDelegate methods
-(void)buttonPressed:(id)sender{
    PMLabelButton *button = (PMLabelButton *)sender;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    if([button isEqual:_pauseButton]){
        _pauseButton.view.hidden = true;
        [_recorder pause];
        
    }
    else if([button isEqual:_resumeButton]){
        _pauseButton.view.hidden = false;
        
        [_recorder record];
    }
    else if([button isEqual:_reRecordButton]){
        
        
        [_recorder stop];
        [session setActive:NO error:nil];
        
        
        [session setActive:YES error:nil];
        
        // Start recording
        [_recorder record];
        
        _pauseButton.view.hidden = false;
        
    }
    
}

#pragma mark - MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:^{
        [_recordingTimer invalidate];
        _recordingTimer = nil;
        [[self navigationController] popViewControllerAnimated:YES];
    }];
}

#pragma mark - MFMessageComposeViewControllerDelegate methods
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:^{
        [_recordingTimer invalidate];
        _recordingTimer = nil;
        [[self navigationController] popViewControllerAnimated:YES];
    }];
}

#pragma mark - AVAudioRecorderDelegate methods


@end
