//
//  DataEntity.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataEntity : NSManagedObject

@property (nonatomic, retain) NSDate * appointmentDate;
@property (nonatomic, retain) NSString * appointmentName;
@property (nonatomic, retain) NSDate * appointmentTime;
@property (nonatomic, retain) NSDate * appointmentToDate;
@property (nonatomic, retain) NSDate * appointmentToTime;
@property (nonatomic, retain) NSString * appointmentType;
@property (nonatomic, retain) NSString * appointmentClientName;
@property (nonatomic, retain) NSString * appointmentCaseId;
@property (nonatomic, retain) NSString * appointmentDescription;
@property (nonatomic, retain) NSString * appointmentVenue;
@property (nonatomic, retain) NSString * appointmentReminder;
@property (nonatomic, retain) NSString * appointmentRecurring;
@property (nonatomic, retain) NSString * appointmentVisibility;
@property (nonatomic, retain) NSString * appointmentHolidayType;

@end
