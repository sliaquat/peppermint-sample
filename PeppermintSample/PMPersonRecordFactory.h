//
//  PMPersonRecordFactory.h
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AddressBook;

@interface PMPersonRecordFactory : NSObject

+(PMPersonRecordFactory *)sharedInstance;
-(void)construct;
-(BOOL)isConstructed;
@end
