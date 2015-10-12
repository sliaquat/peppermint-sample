//
//  PMContactsDefaultViewController.m
//  PeppermintSample
//
//  Created by Sanad on 10/3/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMContactsDefaultViewController.h"
#import "UIColor-Expanded.h"
#import "PMGlobalConstants.h"

@interface PMContactsDefaultViewController ()

@end

@implementation PMContactsDefaultViewController

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        //
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIFont *font=[UIFont fontWithName:@"OpenSans-Semibold" size:14.0];
    
    //Bottom Line 1
    NSMutableAttributedString *attrString = [self.bottomLabelLine1.attributedText mutableCopy];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.string.length)];
    self.bottomLabelLine1.attributedText = attrString;

    //Bottom Line 2
    attrString = [self.bottomLabelLine2.attributedText mutableCopy];
    [attrString addAttribute: NSForegroundColorAttributeName value:[UIColor colorWithHexString:global_colorJetStream] range:[[attrString string] rangeOfString:@"Peppermint"]];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.string.length)];
    self.bottomLabelLine2.attributedText = attrString;
    
    
    self.topLabel.alpha = 0.0;
    self.bottomLabelLine1.alpha = 0.0;
    self.bottomLabelLine2.alpha = 0.0;
    
    
    if(IS_IPHONE_4){
        _imageTopConstraint.constant = 7;
        _imageBottomConstraint.constant = 7;
        _topLabelHeightConstraint.constant = 30 ;
        _topLabelWidthConstraint.constant = 300;
        
        //Bottom Line 2
        attrString = [self.topLabel.attributedText mutableCopy];
        font=[UIFont fontWithName:@"OpenSans-Semibold" size:18.0];
        [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.string.length)];
        self.topLabel.attributedText = attrString;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onContactFound:(BOOL)contactsFound{
    if(contactsFound){
        self.topLabel.alpha = 0.0;
        self.bottomLabelLine1.alpha = 0.0;
        self.bottomLabelLine2.alpha = 0.0;
    }
    else{
        self.topLabel.alpha = 0.5;
        self.bottomLabelLine1.alpha = 1.0;
        self.bottomLabelLine2.alpha = 1.0;

    }
}


@end
