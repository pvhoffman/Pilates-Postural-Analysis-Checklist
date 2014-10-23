//
//  MasterViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/21/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "PACPlumbLineViewController.h"
#import "PACRelativeAlignmentViewController.h"
#import "PACSideViewTableViewController.h"

#import "PACGlobal.h"


enum {
    tableViewItemPlumbLine               = 0
        , tableViewItemAlignedInRelation = 1
        , tableViewItemSideView          = 2
        , tableViewItemFrontView         = 3
        , tableViewItemBackView          = 4
        , tableViewItemCount             = 5
};

static NSString* cell_identifier = @"master-view-cell";

@interface MasterViewController ()
-(void) mainCheckListDidChange:(NSNotification*)notification; 

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib 
{
    [super awakeFromNib];
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    [self.tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];

    self.navigationItem.title = @"Main";//[detailItem description];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainCheckListDidChange:) name:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];


}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender 
{
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
/*
#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}
*/
#pragma mark - Table View
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

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
    }
    cell.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;

    switch(indexPath.row){
        case tableViewItemPlumbLine:
            cell.textLabel.text  = @"Plumb Line";
            //cell.imageView.image = [UIImage imageNamed:@"plumbline_main.jpg"];
            if((PACChecklistMain & mainChecklistPlumbline) == mainChecklistPlumbline){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;
        case tableViewItemAlignedInRelation:
            cell.textLabel.text = @"Relative Alignment";
            //cell.imageView.image = [UIImage imageNamed:@"alignment_main.jpg"];
            if((PACChecklistMain & mainChecklistAlignedInRelation) == mainChecklistAlignedInRelation){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;
        case tableViewItemSideView:
            cell.textLabel.text = @"Side View";//[NSString stringWithFormat:@"cell %d", (int)indexPath.row];
            //cell.imageView.image = [UIImage imageNamed:@"sideview.jpg"];
            break;
        case tableViewItemFrontView:
            cell.textLabel.text = @"Front View";//[NSString stringWithFormat:@"cell %d", (int)indexPath.row];
            //cell.imageView.image = [UIImage imageNamed:@"frontview.jpg"];
            break;
        case tableViewItemBackView:
            cell.textLabel.text = @"Back View";//[NSString stringWithFormat:@"cell %d", (int)indexPath.row];
            //cell.imageView.image = [UIImage imageNamed:@"frontview.jpg"];
            break;
        default:
            cell.textLabel.text = [NSString stringWithFormat:@"cell %d", (int)indexPath.row];
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    switch(indexPath.row){
        case tableViewItemPlumbLine:
            [self.navigationController pushViewController:[[PACPlumbLineViewController alloc] init] animated:YES];
            break;
        case tableViewItemAlignedInRelation:
            [self.navigationController pushViewController:[[PACRelativeAlignmentViewController alloc] init] animated:YES];
            break;
        case tableViewItemSideView:
            [self.navigationController pushViewController:[[PACSideViewTableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            break;
        case tableViewItemFrontView:
            break;
        case tableViewItemBackView:
            break;
        default:
            break;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}
#pragma mark -
-(void) mainCheckListDidChange:(NSNotification*)notification;
{
        [self.tableView reloadData];
}
@end

