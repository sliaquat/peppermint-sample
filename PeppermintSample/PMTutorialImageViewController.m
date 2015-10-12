//
//  PMTutorialImageViewController.m
//  PeppermintSample
//
//  Created by Sanad on 10/1/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMTutorialImageViewController.h"
#import "UIImage+Size.h"

@interface PMTutorialImageViewController (){
    NSString *_imageName;
}

@end

@implementation PMTutorialImageViewController

- (instancetype)initWithImageName:(NSString *)imageName{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _imageName = imageName;
    }
    return self;
}

+(PMTutorialImageViewController *)viewControllerWithImageNamed:(NSString *)imageName{
    return [[PMTutorialImageViewController alloc]  initWithImageName:imageName];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.imageView.image = [UIImage sizedImageWithName:_imageName];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
