//
//  PMPageViewController.h
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FXPageControl, PMTutorialViewControllerDelegateAndDataSource;
@interface PMTutorialPageViewController : UIPageViewController{
    
}

@property (nonatomic, strong) FXPageControl *pageControl;
@property (nonatomic, strong) PMTutorialViewControllerDelegateAndDataSource *tVCDelegateAndDataSource;

@end
