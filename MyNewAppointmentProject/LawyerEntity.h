//
//  LawyerEntity.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LawyerEntity : NSManagedObject

@property (nonatomic, retain) NSString * lawyerID;
@property (nonatomic, retain) NSString * chamberID;

@end
