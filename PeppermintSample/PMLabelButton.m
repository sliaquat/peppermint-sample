//
//  MyButton.m
//  TestApplication
//
//  Created by Sanad Liaquat on 12/4/11.
//  Copyright (c) 2011 Thoughtworks Inc. All rights reserved.
//

#import "PMLabelButton.h"
#import "UIColor-Expanded.h"
#import "PMGlobalConstants.h"

@implementation PMLabelButton{
    UIImage *_baseImage;
    UIImage *_highlightedImage;
    UILongPressGestureRecognizer* _tapRecognizer;
}

- (id)initWithBaseImageName:(NSString *)baseImageName highlightImageName:(NSString *)highlightImageName labelText:(NSString *)labeltxt{
    return [self initWithNibName:@"PMLabelButton" baseImageName:baseImageName highlightImageName:highlightImageName labelText:labeltxt];
}

- (id)initWithNibName:(NSString *)nibName baseImageName:(NSString *)baseImageName highlightImageName:(NSString *)highlightImageName labelText:(NSString *)labeltxt
{
    self = [super init];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        _tapRecognizer = [[UILongPressGestureRecognizer alloc]
                          initWithTarget:self
                          action:@selector(tapped:)];
        [self.view addGestureRecognizer: _tapRecognizer];
        _tapRecognizer.minimumPressDuration = 0.01;
        
        _baseImage = [UIImage imageNamed:baseImageName];
        self.baseImageView.image = _baseImage;
        
        
        _highlightedImage = [UIImage imageNamed:highlightImageName];
        self.label.text = labeltxt;
        self.label.textColor = [UIColor colorWithHexString:global_colorCascade];
        
        
    }
    return self;
}


- (void) tapped:(UILongPressGestureRecognizer*) tp {
    if(tp.state == UIGestureRecognizerStateBegan || tp.state == UIGestureRecognizerStateChanged){
        self.baseImageView.image = _highlightedImage;
        self.label.textColor = [UIColor blackColor];
    }
    
    if(tp.state == UIGestureRecognizerStateEnded){
        self.baseImageView.image = _baseImage;
        self.label.textColor = [UIColor colorWithHexString:global_colorCascade];
        [self.delegate buttonPressed:self];
    }
    
}



@end
