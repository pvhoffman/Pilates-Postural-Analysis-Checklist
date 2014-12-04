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
// #import "PACRelativeAlignmentViewController.h"
#import "PACSideViewTableViewController.h"
#import "PACFrontViewTableViewController.h"
#import "PACBackViewTableViewController.h"
#import "PACGlobal.h"


enum {
	tableViewItemPlumbLine               = 0
/*
        , tableViewItemAlignedInRelation = 1
 */
	, tableViewItemSideView          = 1
	, tableViewItemFrontView         = 2
	, tableViewItemBackView          = 3
	, tableViewItemCount             = 4
};

static NSString* cell_identifier = @"master-view-cell";

@interface MasterViewController ()
-(void) mainCheckListDidChange:(NSNotification*)notification;
-(void) menuButtonClicked:(id)sender;
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

	UIBarButtonItem* barItem1 = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Menu", @"")
	                             style:UIBarButtonItemStylePlain
	                             target:self
	                             action:@selector(menuButtonClicked:)];
	//barItem1.tag = tagBarButtonMenu;
	//[self.navigationBar.topItem setRightBarButtonItem:barItem1 animated:NO];
	//[barItem1 release];

	[self.navigationController.navigationBar.topItem setRightBarButtonItem:barItem1 animated:NO];



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

	switch(indexPath.row) {
	case tableViewItemPlumbLine:
		cell.textLabel.text  = @"Plumb Line";
		cell.imageView.image = pac_plumbline_indicator();
		if((PACChecklistMain & mainChecklistPlumbline) == mainChecklistPlumbline) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemSideView:
		cell.textLabel.text = @"Side View";
		cell.imageView.image = pac_sideview_indicator();
		if((PACChecklistMain & mainChecklistSideView) == mainChecklistSideView) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemFrontView:
		cell.textLabel.text = @"Front View";
		cell.imageView.image = pac_frontview_indicator();
		if((PACChecklistMain & mainChecklistFrontView) == mainChecklistFrontView) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemBackView:
		cell.textLabel.text = @"Back View";
		cell.imageView.image = pac_backview_indicator();
		if((PACChecklistMain & mainChecklistBackView) == mainChecklistBackView) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	default:
		cell.textLabel.text = [NSString stringWithFormat:@"cell %d", (int)indexPath.row];
		break;
	}
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch(indexPath.row) {
	case tableViewItemPlumbLine: {
		PACPlumbLineViewController* view_controller =  [[PACPlumbLineViewController alloc] init];
		[self.navigationController pushViewController:view_controller animated:YES];
		break;
	}
/*
        case tableViewItemAlignedInRelation: {
            PACRelativeAlignmentViewController* view_controller = [[PACRelativeAlignmentViewController alloc] init];
            [self.navigationController pushViewController:view_controller animated:YES];
            break;
                                             }

 */
	case tableViewItemSideView: {
		PACSideViewTableViewController* view_controller = [[PACSideViewTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
		[self.navigationController pushViewController:view_controller animated:YES];
		break;
	}
	case tableViewItemFrontView: {
		PACFrontViewTableViewController* view_controller = [[PACFrontViewTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
		[self.navigationController pushViewController:view_controller animated:YES];
		break;
	}
	case tableViewItemBackView:
		[self.navigationController pushViewController:[[PACBackViewTableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	CGRect frame = tableView.frame;

	UIView* res = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, 215.0f)];

	res.backgroundColor = [UIColor whiteColor];

	UIImage* image = [UIImage imageNamed:@"main-view.jpg"];

	UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, image.size.height)];
	image_view.contentMode = UIViewContentModeScaleAspectFit;
	image_view.image = image;

	[res addSubview:image_view];

	return res;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 215.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 0.0f;
}
#pragma mark -
#pragma mark Private
-(void) mainCheckListDidChange:(NSNotification*)notification;
{
	[self.tableView reloadData];
}
-(void) menuButtonClicked:(id)sender
{
	// menu items:
	// Save Profile
	// New Profile
	// Email Analysis
}
@end

