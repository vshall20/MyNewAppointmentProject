//
//  NewAppointmentViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 05/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "NewAppointmentViewController.h"
#import "MyNavigationBar.h"
#import "MyTabBar.h"
#import "AddEditAppoinmentViewController.h"
#import "MyAppoinmentSaveCancelView.h"
#import "MyDropDownViewController.h"

@interface NewAppointmentViewController ()<MyDropDownViewControllerDelegate>

{
    MyNavigationBar  *obj_MyNavigationBar;
    MyTabBar         *obj_MyTabBar;
    NSArray          *nib;
    MyAppoinmentSaveCancelView *obj_SaveCancelView;
    AddEditAppoinmentViewController *obj_addEditViewController;
}
@end

@implementation NewAppointmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    nib = [[NSBundle mainBundle] loadNibNamed:@"myNavigationBar" owner:self options:nil];
    
    obj_MyNavigationBar = (MyNavigationBar *)[nib objectAtIndex:0];
    obj_MyNavigationBar.myNavigationItem.title = @"New Appointment";
    //obj_MyNavigationBar.frame = CGRectMake(0, 0, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
  
    [self.view addSubview:obj_MyNavigationBar];
    // Do any additional setup after loading the view from its nib.
    if (nib)
    {
        nib = nil;
    }
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyAppoinmentSaveCancelView" owner:self options:nil];
    
    obj_SaveCancelView = (MyAppoinmentSaveCancelView *)[nib objectAtIndex:0];
    obj_SaveCancelView.frame = CGRectMake(0,obj_MyNavigationBar.frame.size.height, obj_SaveCancelView.frame.size.width, obj_SaveCancelView.frame.size.height);
    [obj_SaveCancelView.btn_DropDownList addTarget:self action:@selector(dropDownListClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:obj_SaveCancelView];
    
    
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyTabBar" owner:self options:nil];
    
    obj_MyTabBar = (MyTabBar *)[nib objectAtIndex:0];
    obj_MyTabBar.frame = CGRectMake(0, self.view.frame.size.height-obj_MyTabBar.frame.size.height, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
    obj_MyTabBar.delegate = self;
    [self.view addSubview:obj_MyTabBar];
    
}
#pragma mark - dropDownListClicked
-(void)dropDownListClicked:(id)sender
{
    if (obj_addEditViewController)
    {
        [self removeAddEditViewController];
    }

    MyDropDownViewController *obj_MyDropDownViewController = [[MyDropDownViewController alloc] initWithNibName:@"MyDropDownViewController" bundle:nil];
    obj_MyDropDownViewController.str_ShowTableContent  = kShowAppointmentType;
    obj_MyDropDownViewController.delegate = self;
    obj_MyDropDownViewController.view.frame = CGRectMake(10, obj_SaveCancelView.frame.size.height+obj_MyNavigationBar.frame.size.height,obj_MyDropDownViewController.view.frame.size.width-20,200);
    [self addChildViewController:obj_MyDropDownViewController];
    [self.view addSubview:obj_MyDropDownViewController.view];
    [obj_MyDropDownViewController didMoveToParentViewController:self];
    
}
#pragma mark - Tab Bar Delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
    NewAppointmentViewController *obj_New = [[NewAppointmentViewController alloc] initWithNibName:@"NewAppointmentViewController" bundle:nil];
    [self.navigationController pushViewController:obj_New animated:YES];
    NSLog(@"item %d",item.tag);
}
#pragma mark - MyDropDownViewController Delegate
-(void)selectedDropDownListTableWithContent:(NSString *)str_Content contentType:(NSString *)str_ContentType
{
    if ([str_ContentType isEqualToString:kShowAppointmentType])
    {
    obj_SaveCancelView.txt_AppointmentType.text  = str_Content;
    }
    
    if (obj_addEditViewController)
    {
        [self removeAddEditViewController];
    }
       if (!obj_addEditViewController)
        {
            obj_addEditViewController = [[AddEditAppoinmentViewController alloc] initWithNibName:@"AddEditAppoinmentViewController" bundle:nil];
            float yOrigin = obj_MyNavigationBar.frame.size.height + obj_SaveCancelView.frame.size.height;
            obj_addEditViewController.str_AppointmentType = str_Content;
            //obj_addEditViewController.delegate = self;
            float viewHeight = obj_MyNavigationBar.frame.size.height + obj_SaveCancelView.frame.size.height + obj_MyTabBar.frame.size.height;
            obj_addEditViewController.view.frame = CGRectMake(0,yOrigin, self.view.frame.size.width, self.view.frame.size.height-viewHeight);
            [self addChildViewController:obj_addEditViewController];
            [self.view addSubview:obj_addEditViewController.view];
            [obj_addEditViewController didMoveToParentViewController:self];
            
    }
    
}
-(void)removeAddEditViewController
{
    [obj_addEditViewController didMoveToParentViewController:nil];
    [obj_addEditViewController.view removeFromSuperview];
    [obj_addEditViewController removeFromParentViewController];
    obj_addEditViewController = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
