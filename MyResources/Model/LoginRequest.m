//
//  LoginRequest.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest


-(id)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    if (!self) {
        self = [[LoginRequest alloc]init];
        _username = username;
        _password = password;
    }
    return self;
}


-(NSMutableDictionary *)fetchLawyerIDandChamberID
{
    NSString *parameterName = [NSString stringWithFormat:@"/eLegalNet_Login?parameter={\"id\":\"chm00101\",\"username\":\"%@\",\"password\":\"%@\",\"flag\":\"1\"}",_username,_password];
    NSLog(@"Parameter name for local login type:=%@",parameterName);
    
    NSMutableDictionary *jsonObject = [[Utility sharedInstance] fetchData:parameterName];
    
    _chamberID = [jsonObject valueForKeyPath:@"logindata.chamberid"];
    _lawyerID  = [jsonObject valueForKeyPath:@"logindata.lawerid"];
    
    return jsonObject;
}

@end
