//
//  MasterViewController.h
//  Energy
//
//  Created by Admin on 27/10/14.
//  Copyright (c) 2014 Ewg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface MasterViewController : UITableViewController;



@property (strong, nonatomic) DetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UITableViewCell *enableGPSCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *autoPopulateCell;

@end

