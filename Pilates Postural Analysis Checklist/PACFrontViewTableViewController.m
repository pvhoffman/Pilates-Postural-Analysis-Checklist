//
//  PACFrontViewTableViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/5/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACFrontViewTableViewController.h"
#import "PACGlobal.h"



enum {
    tableViewItemFeet = 0
        , tableViewItemKnees
        , tableViewItemPelvis
        , tableViewItemRibcage
        , tableViewItemShoulders
        , tableViewItemHead
        , tableViewItemCount
};

static NSString* cell_identifier = @"frontview-view-cell";

@interface PACFrontViewTableViewController ()

@end

@implementation PACFrontViewTableViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];

    self.navigationItem.title = @"Front View";
    
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return tableViewItemCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];
    
    cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;

    switch(indexPath.row){
        case tableViewItemFeet:
            cell.textLabel.text  = @"Feet";
            break;
        case tableViewItemKnees:
            cell.textLabel.text  = @"Knees";
            break;
        case tableViewItemPelvis:
            cell.textLabel.text  = @"Pelvis";
            break;
        case tableViewItemRibcage:
            cell.textLabel.text  = @"Rib Cage";
            break;
        case tableViewItemShoulders:
            cell.textLabel.text  = @"Shoulders";
            break;
        case tableViewItemHead:
            cell.textLabel.text  = @"Head";
            break;
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
}

@end
