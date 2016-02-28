//
//  ViewController.m
//  CoreDataLists
//
//  Created by Jeremy Hartmann on 2016-02-26.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "ViewController.h"
#import "Courses.h"

@interface ViewController ()

@end

@implementation ViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addCourse"])
    {
        AddCourseViewController *acvc = (AddCourseViewController *)[segue destinationViewController];
        acvc.delegate = self;
        
        Courses *newCourse = (Courses *) [NSEntityDescription insertNewObjectForEntityForName:@"Courses" inManagedObjectContext:[self managedObjectContext]];
        
        acvc.currentCourse = newCourse;
    }
}


////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error])
    {
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

/////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [secInfo numberOfObjects];
}

////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell.
    Courses *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = course.title;   

    return cell;
}

////////////////////////////////////////////////////////////////
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    
}



#pragma mark - 
#pragma Fetched REsults Controller Section
////////////////////////////////////////////////////////////////
- (NSFetchedResultsController *) fetchedResultsController
{
    if (_fetchedResultsController != nil){
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

    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"author" cacheName:nil];
    
    return _fetchedResultsController;
}

@end
