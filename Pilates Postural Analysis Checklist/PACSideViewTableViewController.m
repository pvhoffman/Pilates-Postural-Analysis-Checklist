//
//  PACSideViewTableViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/23/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACSideViewTableViewController.h"
#import "PACAnkleJointsViewController.h"
#import "PACKneeSideViewController.h"
#import "PACHipJointViewController.h"
#import "PACPelvisSideViewController.h"
#import "PACLumbarSpineViewController.h"
#import "PACGlobal.h"

enum {
        tableViewItemAnkleJoints          = 0
            , tableViewItemKnees          = 1
            , tableViewItemHipJoints      = 2
            , tableViewItemPelvis         = 3
            , tableViewItemLumbarSpine    = 4
            , tableViewItemLowerThoracicSpine = 5
            , tableViewItemUpperThoracicSpine = 6
            , tableViewItemCervicalSpine  = 7
            , tableViewItemHead           = 8
            , tableViewItemCount          = 9
};

static NSString* cell_identifier = @"sideview-view-cell";

@interface PACSideViewTableViewController ()
-(void) sideViewCheckListDidChange:(NSNotification*)notification; 
@end

@implementation PACSideViewTableViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    [self.tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];

    self.navigationItem.title = @"Side View";//[detailItem description];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sideViewCheckListDidChange:) name:[NSString stringWithUTF8String:PACCheckListSideViewDidChange] object:nil];
   // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    return tableViewItemCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
    }

    cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;

    switch(indexPath.row){
        case tableViewItemAnkleJoints:

            if((PACChecklistSideView & sideViewCheckListAnkleJoint) == sideViewCheckListAnkleJoint){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Ankle Joints";
            break;
        case tableViewItemKnees:
            if((PACChecklistSideView & sideViewCheckListKnee) == sideViewCheckListKnee){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Knees";
            break;
        case tableViewItemHipJoints:
            if((PACChecklistSideView & sideViewCheckListHipJoint) == sideViewCheckListHipJoint){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Hip Joints";
            break;
        case tableViewItemPelvis:
            if((PACChecklistSideView & sideViewCheckListPelvis) == sideViewCheckListPelvis){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Pelvis";
            break;
        case tableViewItemLumbarSpine:
            if((PACChecklistSideView & sideViewCheckListLumbar) == sideViewCheckListLumbar){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Lumbar Spine";
            break;
        case tableViewItemLowerThoracicSpine:
            cell.textLabel.text  = @"Lower Thracic Spine";
            break;
        case tableViewItemUpperThoracicSpine:
            cell.textLabel.text  = @"Upper Thracic Spine";
            break;
        case tableViewItemCervicalSpine:
            cell.textLabel.text  = @"Cervical Spine";
            break;
        case tableViewItemHead:
            cell.textLabel.text  = @"Head";
            break;
 
    }
 
    
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    switch(indexPath.row){
        case tableViewItemAnkleJoints:
            [self.navigationController pushViewController:[[PACAnkleJointsViewController alloc] init] animated:YES];
            break;
        case tableViewItemKnees:
            [self.navigationController pushViewController:[[PACKneeSideViewController alloc] init] animated:YES];
            break;
        case tableViewItemHipJoints:
            [self.navigationController pushViewController:[[PACHipJointViewController alloc] init] animated:YES];
            break;
        case tableViewItemPelvis:
            [self.navigationController pushViewController:[[PACPelvisSideViewController alloc] init] animated:YES];
            break;
        case tableViewItemLumbarSpine:
            [self.navigationController pushViewController:[[PACLumbarSpineViewController alloc] init] animated:YES];
            break;
        case tableViewItemLowerThoracicSpine:
            break;
        case tableViewItemUpperThoracicSpine:
            break;
        case tableViewItemCervicalSpine:
            break;
        case tableViewItemHead:
            break;
    }
}
 
-(void) sideViewCheckListDidChange:(NSNotification*)notification
{
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
