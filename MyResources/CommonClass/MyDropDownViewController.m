//
//  MyDropDownViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 10/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "MyDropDownViewController.h"
#import "LinkToCaseIdAutoFilterModel.h"

#define getAutoFilterClientName @"ViewByCaseID_AutoFilter_ClientName_CaseID"
#define getCaseIdBtClientName   @"ViewByCaseID_Fill_CaseID_ByClientName"

@interface MyDropDownViewController ()<UITextFieldDelegate,UtilityDelegate>
{
    NSArray         *arr_AppointmentType;
    NSMutableArray  *arr_LinkToCaseId;
    NSMutableArray  *arr_LinkToCaseIdTempData; /// to store previous data auto filter name
    NSArray         *arr_Venue;
    ViewByCaseIdMode _viewByCaseIdMode;
    
}

@end

@implementation MyDropDownViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    arr_AppointmentType = [NSArray arrayWithObjects:@"Matter",@"Consulation",@"Discussion",@"Event",@"Birthday",@"Anniversary",@"Holiday", nil];
//    arr_LinkToCaseId = [NSArray arrayWithObjects:@"fff83d8b-3c03-429d-81d8-f0a7a6064e19",@"58353398-631e-46a3-9022-815f88f001af", nil];
    arr_Venue = [NSArray arrayWithObjects:@"dfgdfgfdg",@"fgfgf",@"fgfgfg",@"rtertrtr",@"rtrtrtret",@"tyrtytry",@"tyrtytyt", nil];
    
    if ([_str_ShowTableContent isEqualToString:kShowAppointmentLinkedToCaseId]) {
       
        [self getAutoFilterClientNameWebservices];
        _txt_ClientName.delegate = self;
        self.tableView.tableHeaderView = _txt_ClientName;
    }
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([_str_ShowTableContent isEqualToString:kShowAppointmentType])
    {
        return arr_AppointmentType.count;
    }
    else if ([_str_ShowTableContent isEqualToString:kShowAppointmentLinkedToCaseId])
    {
        return arr_LinkToCaseId.count;
    }
    else{
        return arr_Venue.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"dropDownCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    if ([_str_ShowTableContent isEqualToString:kShowAppointmentType])
    {
        cell.textLabel.text = [arr_AppointmentType objectAtIndex:indexPath.row];
    }
    else if ([_str_ShowTableContent isEqualToString:kShowAppointmentLinkedToCaseId])
    {
        LinkToCaseIdAutoFilterModel *model = (LinkToCaseIdAutoFilterModel *)[arr_LinkToCaseId objectAtIndex:indexPath.row];
        if (_viewByCaseIdMode == ViewByCaseIdAutoFilterWebservicesCalled)
        {
           cell.textLabel.text = model.str_ClientName;
        }
        else if (_viewByCaseIdMode == ViewByCaseIdGetCaseIdByClientNameWebservicesCalled)
        {
           cell.textLabel.text = model.str_CaseId;
        }
    }
    else{
       cell.textLabel.text = [arr_Venue objectAtIndex:indexPath.row];
    }

    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str_Content;
    if ([_str_ShowTableContent isEqualToString:kShowAppointmentType])
    {
        str_Content = [arr_AppointmentType objectAtIndex:indexPath.row];
        [self didMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];

    }
    else if ([_str_ShowTableContent isEqualToString:kShowAppointmentLinkedToCaseId])
    {
        if (_viewByCaseIdMode == ViewByCaseIdAutoFilterWebservicesCalled)
        {
            LinkToCaseIdAutoFilterModel *model = (LinkToCaseIdAutoFilterModel *)[arr_LinkToCaseId objectAtIndex:indexPath.row];
            [self getCaseIdByClientNameFromClientName:model.str_ClientName];

        }
        else if (_viewByCaseIdMode == ViewByCaseIdGetCaseIdByClientNameWebservicesCalled)
        {
            //str_Content = [arr_LinkToCaseId objectAtIndex:indexPath.row];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else{
        str_Content = [arr_Venue objectAtIndex:indexPath.row];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [_delegate selectedDropDownListTableWithContent:str_Content contentType:_str_ShowTableContent];
    
 
}
#pragma mark - Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
#pragma mark _ Call webservices Method 
-(void)getAutoFilterClientNameWebservices
{
    NSMutableDictionary  *dict =  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",@"search",@"680c1005-b448-4b7d-8f52-c0bbf21ea416",@"id",nil];
    Utility *util = [Utility sharedInstance];
    [util setDelegate:self];
    [util fetchDataWithMethodName:getAutoFilterClientName andParameterDictionary:dict];
}
-(void)getCaseIdByClientNameFromClientName:(NSString *)name
{
    _viewByCaseIdMode = ViewByCaseIdAutoFilterWebservicesCalled;
    
    NSMutableDictionary  *dict =  [[NSMutableDictionary alloc]initWithObjectsAndKeys:name,@"clientname",@"0",@"mode",@"77ec0754-a225-472a-8d1a-1e34eb459d90",@"chamberid",@"680c1005-b448-4b7d-8f52-c0bbf21ea416",@"loggeduserid",@"1",@"status",nil];
    Utility *util = [Utility sharedInstance];
    [util setDelegate:self];
    [util fetchDataWithMethodName:getCaseIdBtClientName andParameterDictionary:dict];
    
}
#pragma mark - Utility Delegate
-(void)inComingResponse:(id)response forRequest:(NSString *)request
{
    if ([request isEqualToString:getAutoFilterClientName])
    {
        [self storeClientNameAndClientIdFromAutoFilterWebservicesResponse:response];
    }
    else if ([request isEqualToString:getCaseIdBtClientName])
    {
        [self storeClientNameAndClientIdFromAutoFilterWebservicesResponse:response];
    }
}

-(void)inComingError:(NSString *)errorMessage forRequest:(NSString *)request
{
    
}
-(void)storeClientNameAndClientIdFromAutoFilterWebservicesResponse:(NSObject *)data
{
    if (arr_LinkToCaseId)
    {
        [arr_LinkToCaseId removeAllObjects];
        arr_LinkToCaseId = nil;
        
        arr_LinkToCaseIdTempData = nil;
    }
    arr_LinkToCaseId = [[NSMutableArray alloc] init];
    for (int i = 0;i<[[data valueForKeyPath:@"data.ja_CLIENTFULLNAME"] count];i++)
    {
        LinkToCaseIdAutoFilterModel *model = [[LinkToCaseIdAutoFilterModel alloc] init];
        model.str_ClientName               = [(NSArray *)[data valueForKeyPath:@"data.ja_CLIENTFULLNAME"] objectAtIndex:i];
        model.str_ClientId               = [(NSArray *)[data valueForKeyPath:@"data.ja_CL_Id"] objectAtIndex:i];
        [arr_LinkToCaseId addObject:model];
    }
    arr_LinkToCaseIdTempData = [NSMutableArray arrayWithArray:arr_LinkToCaseId];
    [self.tableView reloadData];
}
-(void)storeCaseIdAndIdFromGetCaseIdByClientNameWebservicesResponse:(NSObject *)data
{
    if (arr_LinkToCaseId)
    {
        [arr_LinkToCaseId removeAllObjects];
        arr_LinkToCaseId = nil;
        
        arr_LinkToCaseIdTempData = nil;
    }
    arr_LinkToCaseId = [[NSMutableArray alloc] init];
    for (int i = 0;i<[[data valueForKeyPath:@"data.ja_CF_CaseID"] count];i++)
    {
        LinkToCaseIdAutoFilterModel *model = [[LinkToCaseIdAutoFilterModel alloc] init];
        model.str_CaseId               = [(NSArray *)[data valueForKeyPath:@"data.ja_CF_CaseID"] objectAtIndex:i];
        model.str_Id               = [(NSArray *)[data valueForKeyPath:@"data.ja_CF_ID"] objectAtIndex:i];
        [arr_LinkToCaseId addObject:model];
    }
    [self.tableView reloadData];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
