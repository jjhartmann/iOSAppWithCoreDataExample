//
//  DisplayEditViewController.h
//  CoreDataLists
//
//  Created by Jeremy Hartmann on 2016-02-27.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Courses.h"

@interface DisplayEditViewController : UIViewController

@property (nonatomic, strong) Courses *currentCourse;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;


@property (weak, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)doneEditing:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
- (IBAction)startEditing:(id)sender;


@end
