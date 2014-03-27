//
//  LoginResponse.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

-(id)initWithDictionary:(NSMutableDictionary *)dict
{
    self = [super init];
    if (self)  {
        self = [[LoginResponse alloc]init];
        _lawyerDictionary = dict;
    }
    return self;
}


-(void)saveData
{
    
}


@end
