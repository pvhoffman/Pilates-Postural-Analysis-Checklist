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
#import "PACLowerThoracicSpineViewController.h"
#import "PACUpperThoracicSpineViewController.h"
#import "PACCervicalSpineViewController.h"
#import "PACHeadSideViewController.h"
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
            if((PACChecklistSideView & sideViewCheckListLowerThoracic) == sideViewCheckListLowerThoracic){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Lower Thoracic Spine";
            break;
        case tableViewItemUpperThoracicSpine:
            if((PACChecklistSideView & sideViewCheckListUpperThoracic) == sideViewCheckListUpperThoracic){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Upper Thoracic Spine";
            break;
        case tableViewItemCervicalSpine:
            if((PACChecklistSideView & sideViewCheckListCervicalSpine) == sideViewCheckListCervicalSpine){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Cervical Spine";
            break;
        case tableViewItemHead:
            if((PACChecklistSideView & sideViewCheckListHead) == sideViewCheckListHead){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text  = @"Head";
            break;
 
    }
    
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
            [self.navigationController pushViewController:[[PACLowerThoracicSpineViewController alloc] init] animated:YES];
            break;
        case tableViewItemUpperThoracicSpine:
            [self.navigationController pushViewController:[[PACUpperThoracicSpineViewController alloc] init] animated:YES];
            break;
        case tableViewItemCervicalSpine:
            [self.navigationController pushViewController:[[PACCervicalSpineViewController alloc] init] animated:YES];
            break;
        case tableViewItemHead:
            [self.navigationController pushViewController:[[PACHeadSideViewController alloc] init] animated:YES];
            break;
    }
}
 
-(void) sideViewCheckListDidChange:(NSNotification*)notification
{
    [self.tableView reloadData];
    
    if((PACChecklistSideView & sideViewCheckListAnkleJoint) == sideViewCheckListAnkleJoint  
            && (PACChecklistSideView & sideViewCheckListKnee) == sideViewCheckListKnee
            && (PACChecklistSideView & sideViewCheckListHipJoint) == sideViewCheckListHipJoint
            && (PACChecklistSideView & sideViewCheckListPelvis) == sideViewCheckListPelvis
            && (PACChecklistSideView & sideViewCheckListLumbar) == sideViewCheckListLumbar
            && (PACChecklistSideView & sideViewCheckListLowerThoracic) == sideViewCheckListLowerThoracic
            && (PACChecklistSideView & sideViewCheckListUpperThoracic) == sideViewCheckListUpperThoracic
            && (PACChecklistSideView & sideViewCheckListCervicalSpine) == sideViewCheckListCervicalSpine
            && (PACChecklistSideView & sideViewCheckListHead) == sideViewCheckListHead){
        if((PACChecklistMain & mainChecklistSideView) != mainChecklistSideView){
            PACChecklistMain = PACChecklistMain | mainChecklistSideView;
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];
        }
    } else {
        if((PACChecklistMain & mainChecklistSideView) == mainChecklistSideView){
            PACChecklistMain = PACChecklistMain & ~mainChecklistSideView;
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];
        }
    }
}


@end
