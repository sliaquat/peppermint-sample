//
//  PMRecordingViewController.h
//  PeppermintSample
//
//  Created by Sanad on 10/11/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMLabelButton.h"
@import AVFoundation;
@import MessageUI;
@class PMPersonRecord;

@interface PMRecordingViewController : UIViewController<PMLabelButtonDelegate, AVAudioRecorderDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>{
    
}
- (IBAction)onSendButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomArea;

- (instancetype)initWithPersonRecord:(PMPersonRecord *)personRecord;
@end
