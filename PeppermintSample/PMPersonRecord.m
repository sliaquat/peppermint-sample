//
//  PMPersonRecord.m
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMPersonRecord.h"

@implementation PMPersonRecord

+(PMPersonRecord *)recordWithFullName:(NSString *)fullname photo:(UIImage *)photo type:(PMRecordType)type value:(NSString *)value{
    PMPersonRecord *record = [[PMPersonRecord alloc] init];
    record.fullName = fullname;
    record.photo = photo;
    record.type = type;
    record.value = value;
    return record;
}
@end
