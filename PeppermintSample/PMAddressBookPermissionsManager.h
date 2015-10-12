//
//  PMAddressBookPermissionsManager.h
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AddressBook;

typedef void(^PMPermissionGrantedBlock)(void);
typedef void(^PMPermissionDeniedBlock)(void);

@interface PMAddressBookPermissionsManager : NSObject

+(void)requestionAddressBookPermissionWithGrantedBlock:(PMPermissionGrantedBlock)permissionGrantedBlock deniedBlock:(PMPermissionDeniedBlock)deniedBlock;

@end
