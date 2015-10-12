//
//  PMTutorialImageViewController.h
//  PeppermintSample
//
//  Created by Sanad on 10/1/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMTutorialImageViewController : UIViewController{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

+(PMTutorialImageViewController *)viewControllerWithImageNamed:(NSString *)imageName;

@end
