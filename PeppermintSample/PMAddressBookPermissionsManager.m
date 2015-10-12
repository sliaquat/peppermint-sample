//
//  PMAddressBookPermissionsManager.m
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMAddressBookPermissionsManager.h"


@implementation PMAddressBookPermissionsManager

+(void)requestionAddressBookPermissionWithGrantedBlock:(PMPermissionGrantedBlock)permissionGrantedBlock deniedBlock:(PMPermissionDeniedBlock)deniedBlock{
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        
        deniedBlock();
        
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        
        permissionGrantedBlock();
        
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted){
                    deniedBlock();
                    return;
                }
                permissionGrantedBlock();
                
            });
        });
    }
}

@end
