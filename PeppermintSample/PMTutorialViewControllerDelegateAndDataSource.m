//
//  PMTutorialViewControllerDelegateAndDataSource.m
//  PeppermintSample
//
//  Created by Sanad on 10/1/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMTutorialViewControllerDelegateAndDataSource.h"
#import "PMTutorialImageViewController.h"

@implementation PMTutorialViewControllerDelegateAndDataSource{
        NSArray *_viewControllersArray;
}


-(PMTutorialViewControllerDelegateAndDataSource *)getCurrentViewController{
    return (PMTutorialViewControllerDelegateAndDataSource *)_viewControllersArray[self.currentPageIndex];
}

#pragma  - UIPageViewControllerDataSource Methods
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [_viewControllersArray indexOfObject:viewController];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return _viewControllersArray[index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [_viewControllersArray indexOfObject:viewController];
    
    
    if (index == [_viewControllersArray count]-1) {
        return nil;
    }
    index++;
    return _viewControllersArray[index];
    
}


#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed{
    
    
    if(finished && completed ){
        
        [self updateCurrentIndexForPageViewController:pageViewController];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kTutorialPageChangedNotification
                                                            object:nil userInfo:nil];
    }
    
    
}


-(void)updateCurrentIndexForPageViewController:(UIPageViewController *)pageViewController{
    
    PMTutorialImageViewController *tutorialVC = [pageViewController.viewControllers objectAtIndex:0];
    
    self.currentPageIndex = [_viewControllersArray indexOfObject:tutorialVC];
}

@end
