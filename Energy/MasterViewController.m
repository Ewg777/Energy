//
//  MasterViewController.m
//  Energy
//
//  Created by Admin on 27/10/14.
//  Copyright (c) 2014 Ewg. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController
const NSInteger enableGPSTag = 1;
const NSInteger autoPopulateTag = 2;

@synthesize autoPopulateCell;
@synthesize enableGPSCell;

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    //self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self createSwitch :enableGPSCell :enableGPSTag];
    [self createSwitch :autoPopulateCell :autoPopulateTag];
}

- (void)createSwitch:(UITableViewCell *)cell :(NSInteger)tag {
    UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    //        [switchview setOn:self.app.gpsAlwaysOn];
    [switchview addTarget:self action:@selector(updateSwitchAtIndexPath: ) forControlEvents:UIControlEventValueChanged];
    [switchview setTag:tag];
    cell.accessoryView = switchview;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.objects.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//
//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
//    return cell;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell;
//    NSArray *ids;
//    if (indexPath.section == 0) {
//        ids = @[@"CellBuildingStat", @"CellShareData",@"CellSaveData",@"CellCollections"];
//        
//    } else
//        if (indexPath.section == 1) {
//            ids = @[@"CellEnableGPS", @"CellAutoPopulateData"];
//        }
//    NSString *cellId = [ids objectAtIndex:indexPath.row];
////    cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    cell = [tableView re];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
//    }
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
////        [switchview setOn:self.app.gpsAlwaysOn];
//        [switchview addTarget:self action:@selector(updateSwitchAtIndexPath: ) forControlEvents:UIControlEventValueChanged];
//        
//        cell.accessoryView = switchview;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    if (indexPath.section == 1 && indexPath.row == 1) {
//    }
//    
//    
//    return cell;
//}

- (void)updateSwitchAtIndexPath:(id)sender {
    UISwitch *switchInCell = (UISwitch *)sender;
    UITableViewCell * cell = (UITableViewCell*) switchInCell.superview;
    UISwitch *switchView = (UISwitch *)cell.accessoryView;
    if ([switchView tag] == enableGPSTag) {
        // enable gps
    } else if ([switchView tag] == autoPopulateTag) {
        // auto populate
    }
//    self.app.gpsAlwaysOn = [switchView isOn];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - Alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:
(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel button clicked");
            break;
        case 1:
            NSLog(@"OK button clicked");
            break;
            
        default:
            break;
    }
}

@end
