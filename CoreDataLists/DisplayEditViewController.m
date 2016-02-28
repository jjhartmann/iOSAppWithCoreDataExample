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
    self.authorField.text = [self.currentCourse title];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-mm-dd"];
    self.dateField.text = [df stringFromDate:[self.currentCourse releaseDate]];
    
}


- (IBAction)doneEditing:(id)sender
{
    
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
