//
//  MyDropDownViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 10/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    ViewByCaseIdAutoFilterWebservicesCalled = 0,
    ViewByCaseIdGetCaseIdByClientNameWebservicesCalled,
   
} typedef ViewByCaseIdMode;

@protocol MyDropDownViewControllerDelegate <NSObject>
-(void)selectedDropDownListTableWithContent:(NSString *)str_Content contentType:(NSString *)str_ContentType;
@end


@interface MyDropDownViewController : UITableViewController <UtilityDelegate>
@property(nonatomic,readwrite)NSString *str_ShowTableContent;
@property(nonatomic,assign)id <MyDropDownViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *txt_ClientName;
@property (nonatomic, readwrite) NSArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *dict_linkToCaseID;

@end
