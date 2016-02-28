//
//  ViewController.m
//  CoreDataLists
//
//  Created by Jeremy Hartmann on 2016-02-26.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "Courses.h"
#import "ViewController.h"
#import "DisplayEditViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize fetchedResultsController = _fetchedResultsController;

////////////////////////////////////////////////////////////////
- (void)addCourseViewControllerDidCancel:(Courses *)courseToDelete {
    NSManagedObjectContext *context = self.managedObjectContext;
    [context deleteObject:courseToDelete];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
////////////////////////////////////////////////////////////////
- (void)addCourseViewControllerDidSave {
    NSError *error = nil;
    NSManagedObjectContext *context = self.managedObjectContext;
    
    if (![context save:&error]) {
        NSLog(@"ERROR! %@", error);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Tranistion to add course view
    if ([[segue identifier] isEqualToString:@"addCourse"]) {
        AddCourseViewController *acvc =
        (AddCourseViewController *)[segue destinationViewController];
        acvc.delegate = self;
        
        Courses *newCourse = (Courses *)[NSEntityDescription
                                         insertNewObjectForEntityForName:@"Courses"
                                         inManagedObjectContext:[self managedObjectContext]];
        
        acvc.currentCourse = newCourse;
    }
    
    // Transistion to edit/view course view
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        DisplayEditViewController  *dvc = (DisplayEditViewController *) [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Courses *selectedCourse = (Courses *) [self.fetchedResultsController objectAtIndexPath:indexPath];
        dvc.currentCourse = selectedCourse;
    }
}

////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Error! %@", error);
        abort();
    }
}

////////////////////////////////////////////////////////////////
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data
////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

/////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> secInfo =
    [[self.fetchedResultsController sections] objectAtIndex:section];
    return [secInfo numberOfObjects];
}

////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell.
    Courses *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = course.title;
    
    return cell;
}

////////////////////////////////////////////////////////////////
- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
}


////////////////////////////////////////////////////////////////
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

////////////////////////////////////////////////////////////////
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

////////////////////////////////////////////////////////////////
- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:{
            Courses *changedCourse = [self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changedCourse.title;
        }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    
    
}

////////////////////////////////////////////////////////////////
- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObjectContext *context = [self managedObjectContext];
        Courses *courseToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:courseToDelete];
        
        NSError *error;
        if (![context save:&error])
        {
            NSLog(@"ERROR! %@", error);
        }
    }
}

#pragma mark -
#pragma Fetched REsults Controller Section
////////////////////////////////////////////////////////////////
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"Courses"
                inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"author" ascending:YES];
    [fetchRequest
     setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]
                                 initWithFetchRequest:fetchRequest
                                 managedObjectContext:self.managedObjectContext
                                 sectionNameKeyPath:@"author"
                                 cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}



@end
