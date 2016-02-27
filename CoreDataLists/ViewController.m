//
//  ViewController.m
//  CoreDataLists
//
//  Created by Jeremy Hartmann on 2016-02-26.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [secInfo numberOfObjects];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - 
#pragma Fetched REsults Controller Section
- (NSFetchedResultsController *) fetchedResultsController
{
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
        [NSEntityDescription entityForName:@"Course"
                    inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor =
        [[NSSortDescriptor alloc] initWithKey:@"author" ascending:YES];
    [fetchRequest
        setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"author" cacheName:nil];
    
    return _fetchedResultsController;
}

@end
