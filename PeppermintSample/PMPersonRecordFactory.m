//
//  PMPersonRecordFactory.m
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMPersonRecordFactory.h"
#import "PMPersonRecord.h"
#import "PMPersonRecordCollection.h"

@implementation PMPersonRecordFactory

static PMPersonRecordFactory *_personRecordFactory = nil;
static BOOL _constructed = false;

+(PMPersonRecordFactory *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _personRecordFactory = [[self alloc] init];
    });
    
    return _personRecordFactory;
}

-(BOOL)isConstructed{
    return _constructed;
}

-(void)construct{
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    for (id record in allContacts){
        ABRecordRef thisContact = (__bridge ABRecordRef)record;
        CFStringRef fullNameCFString = ABRecordCopyCompositeName(thisContact);
        
        if(fullNameCFString){
            NSString * fullName =   (__bridge NSString *)fullNameCFString;
            
            
            UIImage *photo = nil;
            if (ABPersonHasImageData(thisContact))
                photo = [UIImage imageWithData:(__bridge NSData *)ABPersonCopyImageDataWithFormat(thisContact, kABPersonImageFormatOriginalSize)];

            
            ABMultiValueRef emails = ABRecordCopyValue(thisContact, kABPersonEmailProperty);
            for (CFIndex ix = 0; ix < ABMultiValueGetCount(emails); ix++) {
                
                CFStringRef value = ABMultiValueCopyValueAtIndex(emails, ix);
                if (value){
                    
                    PMPersonRecord *personRecord = [PMPersonRecord recordWithFullName:fullName photo:photo type:PMRecordTypeEmail value:(__bridge NSString *)(value)];
                    [[PMPersonRecordCollection sharedInstance] addRecord:personRecord];
                    CFRelease(value);
                }
                
                
            }
            
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
            for (CFIndex ix = 0; ix < ABMultiValueGetCount(phoneNumbers); ix++) {
                CFStringRef value = ABMultiValueCopyValueAtIndex(phoneNumbers, ix);
                if (value){
                    PMPersonRecord *personRecord = [PMPersonRecord recordWithFullName:fullName photo:photo type:PMRecordTypePhone value:(__bridge NSString *)(value)];
                    [[PMPersonRecordCollection sharedInstance] addRecord:personRecord];
                    CFRelease(value);
                }
            }
               CFRelease(fullNameCFString);
        }
        
    }
    
    _constructed = true;
    
}

@end
