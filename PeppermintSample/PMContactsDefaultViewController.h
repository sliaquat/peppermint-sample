//
//  PMContactsDefaultViewController.h
//  PeppermintSample
//
//  Created by Sanad on 10/3/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMContactsDefaultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabelLine1;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabelLine2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLabelWidthConstraint;

-(void)onContactFound:(BOOL)contactsFound;

@end
