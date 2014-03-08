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

-(NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:kNameEntityName inManagedObjectContext:self.bgManagedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"appId" ascending:NO];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.bgManagedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

-(void)performFetch
{
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
            // Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    
}

-(void)performFetchWithPredicateString:(NSString *)predicateString
{
    NSPredicate *predicate;
    if ([predicateString isEqualToString:@"All"]) {
        predicateString = nil;
    }
    else
    {
        predicate = [NSPredicate predicateWithFormat:@"appointmentType like %@",predicateString];
    }
    
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    [self performFetch];
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
