//
//  DataRequest.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DataRequest.h"

@implementation DataRequest


-(id)initWithlawyerID:(NSString *)lawyerID andChamberID:(NSString *)chamberID
{
    if (!self) {
        self = [[DataRequest alloc]init];
        _lawyerID = lawyerID;
        _chamberID = chamberID;
    }
    return self;
}


-(NSMutableDictionary *)fetchData
{
    NSString *parameterName = [NSString stringWithFormat:@"/eLegalNet_GetAppointments?parameter={\"search\":\" 11/18/2013\",\"lawyerid\":\"%@\",\"caseid\":\"\",\"appointmenttype\":\"\",\"chamberid\":\"%@\",\"logintype\":\"lawyer\"}",_lawyerID,_chamberID];
    
    NSLog(@"Parameter name for local login type:=%@",parameterName);
    
    NSMutableDictionary *jsonObject = [[Utility sharedInstance] fetchData:parameterName];
    
    return jsonObject;
}


@end
