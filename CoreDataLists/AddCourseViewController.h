//
//  AddCourseViewController.h
//  CoreDataLists
//
//  Created by Jeremy Hartmann on 2016-02-27.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Courses.h"

@protocol AddCourseViewControllerDelegate;


@interface AddCourseViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerField;

@property (nonatomic, weak) id <AddCourseViewControllerDelegate> delegate;

@property (nonatomic, strong) Courses *currentCourse;


- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@end


@protocol AddCourseViewControllerDelegate
- (void) addCourseViewControllerDidSave;
- (void) addCourseViewControllerDidCancel:(Courses *)courseToDelete;
@end


