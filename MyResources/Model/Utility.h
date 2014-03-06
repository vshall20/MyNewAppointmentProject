//
//  Utility.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface Utility : NSObject

@property (nonatomic, assign) BOOL isNetworkConnectionAvailable;
@property (nonatomic, strong) NSString *chamberID;
@property (nonatomic, strong) NSString *lawyerID;

- (void) startConnectionCheck;
+(Utility *)sharedInstance;
-(NSMutableDictionary *)fetchData:(NSString *)webMethod;
-(void)fetchDataAndSave:(NSString *)parameterName;
@end
