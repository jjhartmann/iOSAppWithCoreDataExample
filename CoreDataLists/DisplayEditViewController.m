//
//  DisplayEditViewController.m
//  CoreDataLists
//
//  Created by Jeremy Hartmann on 2016-02-27.
//  Copyright © 2016 Jeremy Hartmann. All rights reserved.
//

#import "DisplayEditViewController.h"

@implementation DisplayEditViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleField.text = [self.currentCourse title];
    self.authorField.text = [self.currentCourse author];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-mm-dd"];
    self.dateField.text = [df stringFromDate:[self.currentCourse releaseDate]];
    
    self.doneButton.hidden = YES;
    
}


- (IBAction)doneEditing:(id)sender
{
    self.titleField.enabled = NO;
    self.authorField.enabled = NO;
    self.dateField.enabled = NO;
    
    self.currentCourse.title = self.titleField.text;
    self.currentCourse.author = self.authorField.text;
    self.currentCourse.releaseDate = self.datePickerView.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-mm-dd"];
    self.dateField.text = [df stringFromDate:[self.currentCourse releaseDate]];
    
    
    self.titleField.borderStyle = UITextBorderStyleNone;
    self.authorField.borderStyle = UITextBorderStyleNone;
    self.dateField.hidden = NO;
    self.datePickerView.hidden = YES;
    
    self.editButton.hidden = NO;
    self.doneButton.hidden = YES;
}

- (IBAction)startEditing:(id)sender
{
    self.titleField.enabled = YES;
    self.authorField.enabled = YES;
    self.dateField.enabled = YES;
    
    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
    self.authorField.borderStyle = UITextBorderStyleRoundedRect;
    self.dateField.hidden = YES;
    self.datePickerView.hidden = NO;
    
    self.editButton.hidden = YES;
    self.doneButton.hidden = NO;
}
@end
