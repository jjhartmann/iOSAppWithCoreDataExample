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


@end
