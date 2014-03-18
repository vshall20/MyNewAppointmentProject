//
//  AddEditAppoinmentViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 10/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataEntity.h"

@protocol AddEditAppointmentViewDelegate <NSObject>

-(void)inviteButtonState:(BOOL)state;

@end

@interface AddEditAppoinmentViewController : UITableViewController
@property (nonatomic,readwrite)NSString    *str_AppointmentType;
@property(strong,nonatomic) DataEntity  *entityData;
@property (nonatomic, weak) id<AddEditAppointmentViewDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *dict_linkToCaseID;
@end
