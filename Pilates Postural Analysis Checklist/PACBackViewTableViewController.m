//
//  PACBackViewTableViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/10/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACBackViewTableViewController.h"
#import "PACFeetBackViewController.h"
#import "PACFemursBackViewController.h"
#import "PACPelvisBackViewController.h"
#import "PACScapulaeBackViewController.h"
#import "PACHumeriBackViewController.h"
#import "PACSpineSequencingBackViewController.h"
#import "PACGlobal.h"

enum {
	tableViewItemFeet = 0
	, tableViewItemFemurs
	, tableViewItemPelvis
	, tableViewItemScapulae
	, tableViewItemHumeri
	, tableViewItemSpineSequencing
	, tableViewItemCount
};

static NSString* cell_identifier = @"backview-view-cell";


@interface PACBackViewTableViewController ()
-(void) backViewCheckListDidChange:(NSNotification*)notification;
@end

@implementation PACBackViewTableViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];

	self.navigationItem.title = @"Back View";

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backViewCheckListDidChange:) name:[NSString stringWithUTF8String:PACCheckListBackViewDidChange] object:nil];

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
	// Return the number of rows in the section.
	return tableViewItemCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];
	cell.accessoryType    = UITableViewCellAccessoryDisclosureIndicator;
	cell.imageView.image = pac_backview_indicator();

	// Configure the cell...
	switch(indexPath.row) {
	case tableViewItemFeet:
		cell.textLabel.text = @"Feet";
		if((PACChecklistBackView & backViewCheckListFeet) == backViewCheckListFeet) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemFemurs:
		cell.textLabel.text = @"Femurs";
		if((PACChecklistBackView & backViewCheckListFemurs) == backViewCheckListFemurs) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemPelvis:
		cell.textLabel.text = @"Pelvis";
		if((PACChecklistBackView & backViewCheckListPelvis) == backViewCheckListPelvis) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemScapulae:
		cell.textLabel.text = @"Scapulae";
		if((PACChecklistBackView & backViewCheckListScapulae) == backViewCheckListScapulae) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemHumeri:
		cell.textLabel.text = @"Humeri";
		if((PACChecklistBackView & backViewCheckListHumeri) == backViewCheckListHumeri) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewItemSpineSequencing:
		cell.textLabel.text = @"Spine Sequencing";
		if((PACChecklistBackView & backViewCheckListSpineSequencing) == backViewCheckListSpineSequencing) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch(indexPath.row) {
	case tableViewItemFeet:
		[self.navigationController pushViewController:[[PACFeetBackViewController alloc] init] animated:YES];
		break;
	case tableViewItemFemurs:
		[self.navigationController pushViewController:[[PACFemursBackViewController alloc] init] animated:YES];
		break;
	case tableViewItemPelvis:
		[self.navigationController pushViewController:[[PACPelvisBackViewController alloc] init] animated:YES];
		break;
	case tableViewItemScapulae:
		[self.navigationController pushViewController:[[PACScapulaeBackViewController alloc] init] animated:YES];
		break;
	case tableViewItemHumeri:
		[self.navigationController pushViewController:[[PACHumeriBackViewController alloc] init] animated:YES];
		break;
	case tableViewItemSpineSequencing:
		[self.navigationController pushViewController:[[PACSpineSequencingBackViewController alloc] init] animated:YES];
		break;
	}
}
#pragma mark -
#pragma mark private
-(void) backViewCheckListDidChange:(NSNotification*)notification
{

	[self.tableView reloadData];

	if((PACChecklistBackView & backViewCheckListFeet) == backViewCheckListFeet
	   && (PACChecklistBackView  & backViewCheckListFemurs) == backViewCheckListFemurs
	   && (PACChecklistBackView  & backViewCheckListPelvis) == backViewCheckListPelvis
	   && (PACChecklistBackView  & backViewCheckListScapulae) == backViewCheckListScapulae
	   && (PACChecklistBackView  & backViewCheckListHumeri) == backViewCheckListHumeri
	   && (PACChecklistBackView  & backViewCheckListSpineSequencing) == backViewCheckListSpineSequencing) {

		if(!((PACChecklistMain & mainChecklistBackView) == mainChecklistBackView)) {
			PACChecklistMain |= mainChecklistBackView;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];
		}
	}
}
@end
