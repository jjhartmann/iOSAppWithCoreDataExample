//
//  AddCourseViewController.m
//  CoreDataLists
//
//  Created by Jeremy Hartmann on 2016-02-27.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "AddCourseViewController.h"

@implementation AddCourseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleField.text = [self.currentCourse title];
    self.authorField.text = [self.currentCourse author];
    self.datePickerField.date = [self.currentCourse releaseDate];
}

- (IBAction)cancel:(id)sender
{
    // dismiss and remove object
    [self.delegate addCourseViewControllerDidCancel:[self currentCourse]];
}

- (IBAction)save:(id)sender
{
    // dismiss modal view controller and save
    [self.currentCourse setTitle:self.titleField.text];
    [self.currentCourse setAuthor:self.authorField.text];
    [self.currentCourse setReleaseDate:self.datePickerField.date];
    
    [self.delegate addCourseViewControllerDidSave];
}
@end
