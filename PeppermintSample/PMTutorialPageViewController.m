//
//  PMPageViewController.m
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMTutorialPageViewController.h"
#import "PMTutorialViewControllerDelegateAndDataSource.h"
#import "PMTutorialImageViewController.h"
#import "PMHelper.h"
#import "FXPageControl.h"
#import "PMAddressBookPermissionsManager.h"
#import "PMPersonRecordFactory.h"

@implementation PMTutorialPageViewController{

    UITapGestureRecognizer *_tapRecognizer;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(onCategoryPageChanged:)
                                                 name: kTutorialPageChangedNotification
                                               object: nil];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc]
                      initWithTarget:self
                      action:@selector(tapped:)];
    
    
    _tVCDelegateAndDataSource = [[PMTutorialViewControllerDelegateAndDataSource alloc] init];
    self.delegate = _tVCDelegateAndDataSource;
    self.dataSource = _tVCDelegateAndDataSource;
    
    NSArray *arrayOfTutorialViewControllers = @[[PMTutorialImageViewController viewControllerWithImageNamed:@"Tutorial-1"], [PMTutorialImageViewController viewControllerWithImageNamed:@"Tutorial-2"], [PMTutorialImageViewController viewControllerWithImageNamed:@"Tutorial-3"]];
    
    _tVCDelegateAndDataSource.viewControllersArray = arrayOfTutorialViewControllers;
    
    [self setViewControllers:@[arrayOfTutorialViewControllers.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    _pageControl = [[FXPageControl alloc] initWithFrame:CGRectMake(0, [PMHelper appFrameHeight]-(IS_IPHONE_4 ? 40 : 45), [PMHelper appFrameWidth], 40)];
    _pageControl.dotImage = [UIImage imageNamed:@"inactive_page_image"];
    
    _pageControl.selectedDotImage = [UIImage imageNamed:@"active_page_image"];
    _pageControl.backgroundColor = [UIColor clearColor];
    
    [_pageControl setNumberOfPages:arrayOfTutorialViewControllers.count];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view addGestureRecognizer:_tapRecognizer];
    [self.view addSubview:_pageControl];
    _pageControl.dotSpacing = 17.0f;
    [_pageControl setCurrentPage:0];
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationNone];
    
}

- (void) tapped:(UITapGestureRecognizer*) tp {
    
    if(tp.state == UIGestureRecognizerStateRecognized){
        
        
        NSInteger nextIndex = _tVCDelegateAndDataSource.currentPageIndex + 1;
                
        if(nextIndex < [_tVCDelegateAndDataSource.viewControllersArray count]){
            
            __weak PMTutorialPageViewController *weakSelf = self;
            
            [self setViewControllers:@[_tVCDelegateAndDataSource.viewControllersArray[nextIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
                [weakSelf.tVCDelegateAndDataSource updateCurrentIndexForPageViewController:weakSelf];
                [weakSelf.pageControl setCurrentPage:nextIndex];
            }];
        }
        else{

            [[NSNotificationCenter defaultCenter] postNotificationName:kTutorialDismissedNotification
                                                                object:nil];
            
        }
        
        
        
    }
    
}


-(void)onCategoryPageChanged:(NSNotification*)notification{
    [_pageControl setCurrentPage:_tVCDelegateAndDataSource.currentPageIndex];
}

@end
