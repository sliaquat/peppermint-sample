//
//  PMTutorialViewControllerDelegateAndDataSource.h
//  PeppermintSample
//
//  Created by Sanad on 10/1/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface PMTutorialViewControllerDelegateAndDataSource : NSObject<UIPageViewControllerDataSource, UIPageViewControllerDelegate>{
    
}
-(void)updateCurrentIndexForPageViewController:(UIPageViewController *)pageViewController;
@property (nonatomic, strong) NSArray *viewControllersArray;
@property (nonatomic) NSInteger currentPageIndex;


@end
