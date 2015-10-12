//
//  ViewController.m
//  PeppermintSample
//
//  Created by Sanad on 10/1/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMMainViewController.h"

#import "PMTutorialPageViewController.h"
#import "PMPersonTableViewController.h"

@interface PMMainViewController (){
    PMTutorialPageViewController *_tutorialPageViewController;
    UINavigationController *_personsNavigationController;
}


@end

@implementation PMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tutorialPageViewController = [[PMTutorialPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    _personsNavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"personsNavigationControllerIdentifier"];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(onTutorialDismissed)
                                                 name: kTutorialDismissedNotification
                                               object: nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self addChildViewController:_tutorialPageViewController];
    [self.view addSubview:[_tutorialPageViewController view]];
    [_tutorialPageViewController didMoveToParentViewController:self];
    _tutorialPageViewController.view.frame = self.view.frame;
 
}

-(void)onTutorialDismissed{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kTutorialDismissedNotification
                                                  object:nil];
    
    [self addChildViewController:_personsNavigationController];
    [self.view insertSubview:_personsNavigationController.view belowSubview:_tutorialPageViewController.view];
    [_personsNavigationController didMoveToParentViewController:self];
    _personsNavigationController.view.frame = self.view.frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        //
        _tutorialPageViewController.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        //
        [_tutorialPageViewController.view removeFromSuperview];
        [_tutorialPageViewController removeFromParentViewController];
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
