//
//  UIImage+UIImage_Size.m
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (UIImage_Size)

+ (UIImage *)sizedImageWithName:(NSString *)name {
    UIImage *image;
    
    if (IS_IPHONE_5) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-568h",name]];
        if (!image) {
            image = [UIImage imageNamed:name];
        }
    }
    else if (IS_IPHONE_6) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-667h",name]];
    }
    else if (IS_IPHONE_6_PLUS) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-736h",name]];
    }
    else {
        image = [UIImage imageNamed:name];
    }
    return image;
}

@end
