//
//  AddEditAppoinmentViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 10/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#define appointmentBasicCell         @"appointmentBasicCell"
#define appointmentTitleCell        @"appointmentTitleCell"
#define appointmentFromToCell       @"appointmentFromToCell"
#define appoinmentDescriptionCell   @"appoinmentDescriptionCell"

#import "AddEditAppoinmentViewController.h"
#import "CustomAppointmentTitleCell.h"
#import "CustomAppointmentFromToCell.h"
#import "CustomAppoinmentDescriptionCell.h"

@interface AddEditAppoinmentViewController ()

@end

@implementation AddEditAppoinmentViewController

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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
                {
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appointmentBasicCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointmentBasicCell];
            }
             return cell;
        }
        break;
        case 1:
        {
            CustomAppointmentTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:appointmentTitleCell];
            if (cell == nil)
            {
                [tableView registerNib:[UINib nibWithNibName:@"CustomAppointmentTitleCell" bundle:nil] forCellReuseIdentifier:appointmentTitleCell];
             
                cell = [tableView dequeueReusableCellWithIdentifier:appointmentTitleCell];
            }
           
            return cell;
        }
            break;
        case 2:
        {
            CustomAppointmentFromToCell *cell = (CustomAppointmentFromToCell*) [tableView dequeueReusableCellWithIdentifier:appointmentFromToCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppointmentFromToCell" owner:self options:nil];
                cell = (CustomAppointmentFromToCell *)[nib objectAtIndex:0];
            }
            
            return cell;
          
        }
            break;
        case 3:
        {
            CustomAppointmentFromToCell *cell = (CustomAppointmentFromToCell*) [tableView dequeueReusableCellWithIdentifier:appointmentFromToCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppointmentFromToCell" owner:self options:nil];
                cell = (CustomAppointmentFromToCell *)[nib objectAtIndex:0];
            }
            
            return cell;
        }
            break;
        case 4:
     
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appointmentBasicCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointmentBasicCell];
                }
                return cell;
            }
            break;
        case 5:
     
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appointmentBasicCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointmentBasicCell];
                }
                return cell;
            }
        break;
        case 6:
        {
            CustomAppoinmentDescriptionCell *cell = (CustomAppoinmentDescriptionCell*) [tableView dequeueReusableCellWithIdentifier:appoinmentDescriptionCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppoinmentDescriptionCell" owner:self options:nil];
                cell = (CustomAppoinmentDescriptionCell *)[nib objectAtIndex:0];
            }
            return cell;
        }
            break;
        case 7:
        {
          
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appointmentBasicCell];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointmentBasicCell];
                }
                return cell;
         
           
        }
            break;
            
            
        default:
            break;
    }
    
    // Configure the cell...
    
    return nil;
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
