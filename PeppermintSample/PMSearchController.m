//
//  PMSearchController.m
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMSearchController.h"
#import "UIColor-Expanded.h"
#import "PMGlobalConstants.h"

@implementation PMSearchController

-(UISearchBar*)searchBar{

        UISearchBar *baseSearchBar = [super searchBar];
    
    // Reference search display controller search bar's text field (in my case).
    UITextField *searchBarTextField = [baseSearchBar valueForKey:@"_searchField"];
    
    // Magnifying glass icon.
    UIImageView *leftImageView = (UIImageView *)searchBarTextField.leftView;
    leftImageView.image = [leftImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    leftImageView.tintColor = [UIColor colorWithHexString:global_colorMonteCarlo];


    return baseSearchBar;
}

@end
