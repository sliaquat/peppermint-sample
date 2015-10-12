//
//  PMPersonRecordCollection.m
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import "PMPersonRecordCollection.h"
#import "PMPersonRecord.h"

@implementation PMPersonRecordCollection{
    NSMutableArray *_collection;
    NSMutableArray *_values;
}

static PMPersonRecordCollection *_personRecordCollection = nil;

+(PMPersonRecordCollection *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _personRecordCollection = [[self alloc] init];
    });
    
    return _personRecordCollection;
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        _collection = [[NSMutableArray alloc] initWithCapacity:1];
        _values = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

-(void)addRecord:(PMPersonRecord *)personRecord{
    if(![_values containsObject:personRecord.value]){
        [_collection addObject:personRecord];
        [_values addObject:personRecord.value];
    }
}


-(NSArray *)allRecords{
    return _collection;
}

-(NSArray *)recordsWithName:(NSString *)keyword{
    if ([keyword isEqualToString:@""]) {
        return @[];
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fullName CONTAINS[cd] %@", keyword];
    NSArray *filteredArray =  [_collection filteredArrayUsingPredicate:predicate];
    
    return filteredArray;
}


@end
