//
//  PMPersonRecordCollection.h
//  PeppermintSample
//
//  Created by Sanad on 10/2/15.
//  Copyright © 2015 SHL Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PMPersonRecord;
@interface PMPersonRecordCollection : NSObject{
    
}

+(PMPersonRecordCollection *)sharedInstance;
-(NSArray *)allRecords;
-(void)addRecord:(PMPersonRecord *)personRecord;
-(NSArray *)recordsWithName:(NSString *)keyword;

@end
