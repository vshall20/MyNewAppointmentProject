//
//  MyAppointmentListViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 04/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "MyAppointmentListViewController.h"
#import "LeftViewController.h"
#import "TKCalendarMonthView.h"
#import "NewAppointmentViewController.h"
#import "MyTabBar.h"
#import "MyNavigationBar.h"
#import "LoginRequest.h"
#import "LoginResponse.h"

#import "DataRequest.h"
#import "DataResponse.h"
#import "AppointmentTypeViewController.h"
#import "FilterByLawyerViewController.h"


@interface MyAppointmentListViewController ()<LeftViewControllerDelegate,TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource,AppointmentTypeDelegate,FilterByLawyerDelegate>

{
    LeftViewController  *obj_LeftViewController;
    TKCalendarMonthView *calendarView;
    MyTabBar            *obj_MyTabBar;
    MyNavigationBar     *obj_MyNavigationBar;
    NSArray             *nib;
    float               tableViewYPosition;
}

@end

@implementation MyAppointmentListViewController

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
    // Do any additional setup after loading the view from its nib.
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"myNavigationBar" owner:self options:nil];
    
    obj_MyNavigationBar = (MyNavigationBar *)[nib objectAtIndex:0];
    obj_MyNavigationBar.myNavigationItem.title = @"Appointment";
    [obj_MyNavigationBar.myLeftBarItem setAction:@selector(leftBarClicked:)];
    [obj_MyNavigationBar.myRightItem setAction:@selector(rightBarClicked:)];
    [self.view addSubview:obj_MyNavigationBar];
    // Do any additional setup after loading the view from its nib.
    if (nib)
    {
        nib = nil;
    }
    
    calendarView = 	[[TKCalendarMonthView alloc] init];
    calendarView.frame = CGRectMake(0, obj_MyNavigationBar.frame.size.height, calendarView.frame.size.width, calendarView.frame.size.height);
    NSLog(@"%f",calendarView.frame.size.height);
    calendarView.delegate = self;
    calendarView.dataSource = self;
    [self.view addSubview:calendarView];
	[calendarView reload];
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyTabBar" owner:self options:nil];
    
    obj_MyTabBar = (MyTabBar *)[nib objectAtIndex:0];
    obj_MyTabBar.frame = CGRectMake(0, self.view.frame.size.height-obj_MyTabBar.frame.size.height, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
    obj_MyTabBar.delegate = self;
    [self.view addSubview:obj_MyTabBar];
    tableViewYPosition = (calendarView.frame.size.height +  obj_MyNavigationBar.frame.size.height);
    _tbl_AppointmentList.frame = CGRectMake(0,tableViewYPosition, _tbl_AppointmentList.frame.size.width,self.view.frame.size.height-(tableViewYPosition+obj_MyTabBar.frame.size.height));

    
    
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Login" message:@"" delegate:self cancelButtonTitle:@"Login" otherButtonTitles: nil];
    [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [av setTag:100];
    [[av textFieldAtIndex:1] setSecureTextEntry:NO];
    [[av textFieldAtIndex:0] setPlaceholder:@"Username"];
    [[av textFieldAtIndex:1] setPlaceholder:@"Password"];
    [[av textFieldAtIndex:0] setText:@"shyam.deore@prod.shriyais.com"];
    [[av textFieldAtIndex:1] setText:@"Password123"];
    [[av textFieldAtIndex:1] setSecureTextEntry:YES];
    [av show];
    

//    NSDictionary *dictValue = [NSDictionary dictionaryWithObjectsAndKeys:@"chm00101",@"id",@"shyam.deore@prod.shriyais.com",@"username",@"Password123",@"password",@"1",@"flag", nil];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self loginWebServiceCallAndResponseToGetChamberIDandLawyerID]; //loginWebService Call.
        [self callTheEventListWebService];     //fetching Events Details WebService Call.
    });

   
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loginWebServiceCallAndResponseToGetChamberIDandLawyerID
{
    LoginRequest *request = [[LoginRequest alloc]initWithUsername:@"shyam.deore@prod.shriyais.com" andPassword:@"Password123"];
    LoginResponse *response = [[LoginResponse alloc]initWithDictionary:[request fetchLawyerIDandChamberID]];
    _chamberID = request.chamberID;
    _lawyerID = request.lawyerID;
    [response saveData];
}


-(void)callTheEventListWebService
{
    
    DataRequest *request = [[DataRequest alloc]initWithlawyerID:_lawyerID andChamberID:_chamberID];
    DataResponse *response = [[DataResponse alloc]initWithDictionary:[request fetchData]];
//    if([[response valueForKey:@"success"] isEqualToString:@"1"])
//    {
    [response saveData];
//    }
//    else{
//        //// failed show alert message 
//    }
    
}
- (IBAction)leftBarClicked:(id)sender {
    
    if (!obj_LeftViewController)
    {
        obj_LeftViewController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
        obj_LeftViewController.delegate = self;
        obj_LeftViewController.view.frame = CGRectMake(0, obj_MyNavigationBar.frame.size.height, 100, 88);
        [self addChildViewController:obj_LeftViewController];
        [self.view addSubview:obj_LeftViewController.view];
        [obj_LeftViewController didMoveToParentViewController:self];
       
    }
    else
    {
        [self removeLeftViewController];
    }
}

- (IBAction)rightBarClicked:(id)sender {
   
    FilterByLawyerViewController *obj_Filterlawyer = [[FilterByLawyerViewController alloc] initWithNibName:@"FilterByLawyerViewController" bundle:nil];
    obj_Filterlawyer.myDelegate = self;
    obj_Filterlawyer.tbl_LawyerList.alpha = 0.0;
    obj_Filterlawyer.view.backgroundColor = [UIColor clearColor];
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:obj_Filterlawyer animated:YES completion:NULL];
    

}
#pragma mark - remove child controller 
-(void)removeLeftViewController
{
    [obj_LeftViewController didMoveToParentViewController:nil];
    [obj_LeftViewController.view removeFromSuperview];
    [obj_LeftViewController removeFromParentViewController];
    obj_LeftViewController = nil;
}
#pragma mark - Left View Controller Delegate 
-(void)leftSideTableViewSelectedWithStringValue:(NSString *)name indexValue:(int)indexValue
{
    [self removeLeftViewController];
    AppointmentTypeViewController *obj_Appointment = [[AppointmentTypeViewController alloc] initWithNibName:@"AppointmentTypeViewController" bundle:nil];
    obj_Appointment.myDelegate = self;
    obj_Appointment.view.backgroundColor = [UIColor clearColor];
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:obj_Appointment animated:YES completion:NULL];
    
}
#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");
    tableViewYPosition = (calendarView.frame.size.height +  obj_MyNavigationBar.frame.size.height);
    _tbl_AppointmentList.frame = CGRectMake(0,tableViewYPosition, _tbl_AppointmentList.frame.size.width,self.view.frame.size.height-(tableViewYPosition+obj_MyTabBar.frame.size.height));
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {
	NSLog(@"calendarMonthView marksFromDate toDate");
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
    
   
    NSMutableArray *marks = [NSMutableArray array];
        
    NSArray *data = [NSArray arrayWithObjects:@"2014-03-07 00:00:00 +0000", nil];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) fromDate:startDate];
    
    NSDate *d = [cal dateFromComponents:comp];
    
    // Init offset components to increment days in the loop by one each time
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];

    
    // for each date between start date and end date check if they exist in the data array
    while (YES) {
        // Is the date beyond the last date? If so, exit the loop.
        // NSOrderedDescending = the left value is greater than the right
        if ([d compare:lastDate] == NSOrderedDescending) {
            break;
        }
        
        // If the date is in the data array, add it to the marks array, else don't
        if ([data containsObject:[d description]]) {
            [marks addObject:[NSNumber numberWithBool:YES]];
        } else {
            [marks addObject:[NSNumber numberWithBool:NO]];
        }
        
        // Increment day using offset components (ie, 1 day in this instance)
        d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
    }
   

	// When testing initially you will have to update the dates in this array so they are visible at the
   	return [NSArray arrayWithArray:marks];

}
#pragma mark - Filter Lawyer Delegate 
-(void)lawyerSelectedWithLawyerName:(NSString *)lawyerName
{
    NSLog(@"lawyerName %@",lawyerName);
}
#pragma mark Appointment Type Delegate 
-(void)appointmentTypeClickedWithAppointmentTypeName:(NSString *)name buttonIndex:(int)indexValue
{
    NSLog(@"indexValue %d",indexValue);
    
}
#pragma mark - Tab Bar Delegate 
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
    NewAppointmentViewController *obj_New = [[NewAppointmentViewController alloc] initWithNibName:@"NewAppointmentViewController" bundle:nil];
    [self.navigationController pushViewController:obj_New animated:YES];
    NSLog(@"item %d",item.tag);
}

@end
