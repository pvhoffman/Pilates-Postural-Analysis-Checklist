//
//  PACFrontViewTableViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/5/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACFrontViewTableViewController.h"
#import "PACFeetFrontViewController.h"
#import "PACKneeFrontViewController.h"
#import "PACPelvisFrontViewController.h"
#import "PACRibCageViewController.h"
#import "PACShouldersFrontViewController.h"
#import "PACHeadFrontViewController.h"
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
-(void) frontViewCheckListDidChange:(NSNotification*)notification;
@end

@implementation PACFrontViewTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];

	self.navigationItem.title = @"Front View";

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(frontViewCheckListDidChange:) name:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];

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
	cell.imageView.image = pac_frontview_indicator();

	switch(indexPath.row) {
	case tableViewItemFeet:
		cell.textLabel.text  = @"Feet";
		if((PACChecklistFrontView & frontViewCheckListFeet) == frontViewCheckListFeet) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemKnees:
		cell.textLabel.text  = @"Knees";
		if((PACChecklistFrontView & frontViewCheckListKnees) == frontViewCheckListKnees) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemPelvis:
		cell.textLabel.text  = @"Pelvis";
		if((PACChecklistFrontView & frontViewCheckListPelvis) == frontViewCheckListPelvis) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemRibcage:
		cell.textLabel.text  = @"Rib Cage";
		if((PACChecklistFrontView & frontViewCheckListRibcage) == frontViewCheckListRibcage) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemShoulders:
		cell.textLabel.text  = @"Shoulders";
		if((PACChecklistFrontView & frontViewCheckListShoulders) == frontViewCheckListShoulders) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemHead:
		cell.textLabel.text  = @"Head";
		if((PACChecklistFrontView & frontViewCheckListHead) == frontViewCheckListHead) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
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

	switch(indexPath.row) {
	case tableViewItemFeet:
		[self.navigationController pushViewController:[[PACFeetFrontViewController alloc] init] animated:YES];
		break;
	case tableViewItemKnees:
		[self.navigationController pushViewController:[[PACKneeFrontViewController alloc] init] animated:YES];
		break;
	case tableViewItemPelvis:
		[self.navigationController pushViewController:[[PACPelvisFrontViewController alloc] init] animated:YES];
		break;
	case tableViewItemRibcage:
		[self.navigationController pushViewController:[[PACRibCageViewController alloc] init] animated:YES];
		break;
	case tableViewItemShoulders:
		[self.navigationController pushViewController:[[PACShouldersFrontViewController alloc] init] animated:YES];
		break;
	case tableViewItemHead:
		[self.navigationController pushViewController:[[PACHeadFrontViewController alloc] init] animated:YES];
		break;



	}

}
#pragma mark -
#pragma mark private
-(void) frontViewCheckListDidChange:(NSNotification*)notification
{
	[self.tableView reloadData];

	if((PACChecklistFrontView & frontViewCheckListFeet) == frontViewCheckListFeet
	   && (PACChecklistFrontView & frontViewCheckListKnees) == frontViewCheckListKnees
	   && (PACChecklistFrontView & frontViewCheckListPelvis) == frontViewCheckListPelvis
	   && (PACChecklistFrontView & frontViewCheckListRibcage) == frontViewCheckListRibcage
	   && (PACChecklistFrontView & frontViewCheckListShoulders) == frontViewCheckListShoulders
	   && (PACChecklistFrontView & frontViewCheckListHead) == frontViewCheckListHead) {
		if(!((PACChecklistMain & mainChecklistFrontView) == mainChecklistFrontView)) {
			PACChecklistMain |= mainChecklistFrontView;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];
		}
	} else {
		if((PACChecklistMain & mainChecklistFrontView) == mainChecklistFrontView) {
			PACChecklistMain &= ~mainChecklistFrontView;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];
		}
	}

}
@end
