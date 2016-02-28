//
//  ViewController.h
//  CoreDataLists
//
//  Created by Jeremy Hartmann on 2016-02-26.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AddCourseViewController.h"

@interface ViewController
    : UITableViewController <UITableViewDelegate,
                             AddCourseViewControllerDelegate,
                             NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

