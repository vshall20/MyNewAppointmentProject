//
//  DataResponse.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DataResponse.h"

@implementation DataResponse


-(id)initWithDictionary:(NSMutableDictionary *)dict
{
    if (!self) {
        self = [[DataResponse alloc]init];
        _dataDictionary = dict;
    }
    return self;
}


-(void)saveData
{
    
}
@end
