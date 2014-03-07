//
//  DataManager.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        self = [[DataManager alloc]init];
        _managedObjectContext = context;
    }
    return self;
}

-(NSManagedObjectContext *)bgManagedObjectContext
{
    if (!_bgManagedObjectContext) {
        _bgManagedObjectContext = [[NSManagedObjectContext alloc]init];
        [_bgManagedObjectContext setPersistentStoreCoordinator:[[AppDelegate delegate] persistentStoreCoordinator]];
    }
    return _bgManagedObjectContext;
}

-(NSFetchedResultsController *)fetchResultController
{
    if (!_fetchResultController) {
        _fetchResultController = [[NSFetchedResultsController alloc] init];
    }
    return _fetchResultController;
}


- (void)saveBGContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.bgManagedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
