//
//  DataManager.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

-(id)init
{
    if (!self) {
        self = [[DataManager alloc]init];
        _managedObjectContext = [[AppDelegate delegate] managedObjectContext];
    }
    return self;
}


-(NSFetchedResultsController *)fetchResultController
{
    if (!_fetchResultController) {
        _fetchResultController = [[NSFetchedResultsController alloc] init];
    }
    return _fetchResultController;
}

@end
