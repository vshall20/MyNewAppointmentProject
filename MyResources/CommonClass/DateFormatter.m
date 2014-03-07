//
//  DateFormatter.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

-(id)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [_dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    }
    return self;
}

static DateFormatter *dateForm = nil;

+(DateFormatter *)sharedDateFormatter
{
    if (!dateForm) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dateForm = [[DateFormatter alloc]init];
        });
    }
    return dateForm;
}

-(NSDate *)dateFromParamString:(NSString *)string
{
    return [_dateFormatter dateFromString:string];
}

@end
