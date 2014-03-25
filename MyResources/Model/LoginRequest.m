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
    self = [super init];
    if (self) {
        self = [[LoginRequest alloc]init];
        _username = username;
        _password = password;
    }
    return self;
}

-(NSString *)servicePath
{
    return @"/Login?";
}

-(NSMutableDictionary *)fetchLawyerIDandChamberID
{
    NSString *parameterName = [NSString stringWithFormat:@"%@parameter={\"id\":\"chm00101\",\"username\":\"%@\",\"password\":\"%@\",\"flag\":\"1\"}",[self servicePath],_username,_password];
    NSLog(@"Parameter name for local login type:=%@",parameterName);
    
    NSMutableDictionary *jsonObject = [[Utility sharedInstance] fetchData:parameterName];
    
    _chamberID = [jsonObject valueForKeyPath:@"logindata.chamberid"];
    _lawyerID  = [jsonObject valueForKeyPath:@"logindata.lawerid"];
    
    [[AppDelegate delegate] setLawyerID:_lawyerID];
    [[AppDelegate delegate] setChamberID:_chamberID];
    
    return jsonObject;
}

@end
