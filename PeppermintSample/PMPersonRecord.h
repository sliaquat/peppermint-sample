//
//  PMPersonRecord.h
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PMRecordType) {
    PMRecordTypeEmail,
    PMRecordTypePhone,
};

@interface PMPersonRecord : NSObject{
    
}

@property (nonatomic, strong) NSString* fullName;
@property (nonatomic, assign) PMRecordType type;
@property (nonatomic, strong) NSString* value;
@property (nonatomic, strong) UIImage *photo;


+(PMPersonRecord *)recordWithFullName:(NSString *)fullname photo:(UIImage *)photo type:(PMRecordType)type value:(NSString *)value;

@end
