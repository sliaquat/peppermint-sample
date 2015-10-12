//
//  PMHelper.h
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PMHelper : NSObject

+(CGFloat)appFrameWidth;
+(CGFloat)appFrameHeight;
+ (id)getRootViewController;
+(CGFloat)getStatusBarHeight;

@end
