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
    NSMutableAttributedString *attrString = [self.bottomLabel.attributedText mutableCopy];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.string.length)];
    [attrString addAttribute: NSForegroundColorAttributeName value:[UIColor colorWithHexString:global_colorJetStream] range:[[attrString string] rangeOfString:@"Peppermint"]];
    self.bottomLabel.attributedText = attrString;

    self.topLabel.alpha = 0.0;
    self.bottomLabel.alpha = 0.0;

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
        self.bottomLabel.alpha = 0.0;
    }
    else{
        self.topLabel.alpha = 0.5;
        self.bottomLabel.alpha = 1.0;

    }
}


@end
