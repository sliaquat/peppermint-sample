//
//  MyButton.h
//  TestApplication
//
//  Created by Sanad Liaquat on 12/4/11.
//  Copyright (c) 2011 Thoughtworks Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol PMLabelButtonDelegate
-(void)buttonPressed:(id)sender;
@end

@interface PMLabelButton : NSObject{

    
}
@property (nonatomic, weak) IBOutlet UIImageView *baseImageView;
@property (nonatomic, weak) IBOutlet UILabel *label;

@property (nonatomic, unsafe_unretained) id <PMLabelButtonDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIView *view;

- (id)initWithBaseImageName:(NSString *)baseImageName highlightImageName:(NSString *)highlightImageName labelText:(NSString *)labeltxt;

@end