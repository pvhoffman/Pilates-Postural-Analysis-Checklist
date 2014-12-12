//
//  PACPelvisBackViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/1/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//
//
#import "PACPelvisBackViewController.h"
#import "PACGlobal.h"

enum {
	tagContentView = 100
	, tagTableView
};

enum {
	tableViewRowPelvisLevel           = 0
	, tableViewRowPelvisElevated = 1
	, tableViewRowPelvisRotated  = 2
	, tableViewRowCount          = 3
};

static NSString* cell_identifier = @"pelvis-back-cell";


@interface PACPelvisBackViewController ()
-(void) segmentvaluechanged:(id)sender;
@end

@implementation PACPelvisBackViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}
-(void) loadView
{
	[super loadView];

	self.navigationItem.title = @"Pelvis - Back";

	CGRect frame = self.view.frame;
	float fy = 5.0f;
	float fgutter = 5.0f;


	UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
	content_view.tag = tagContentView;
	content_view.backgroundColor = [UIColor whiteColor];

	UIImage* image = [UIImage imageNamed:@"pelvis_back_detail.jpg"];

	UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake( (frame.size.width / 2.0f) - (image.size.width / 2.0f), fy, image.size.width, image.size.height)];
	image_view.image = image;
	[content_view addSubview:image_view];

	fy = fy + image.size.height + fgutter;

	UIImage* look = [UIImage imageNamed:@"look.jpg"];
	UIImageView* look_view = [[UIImageView alloc] initWithFrame:CGRectMake( 5.0f, fy, look.size.width, look.size.height )];
	look_view.image = look;
	[content_view addSubview:look_view];

	UIImage* touch = [UIImage imageNamed:@"touch.jpg"];
	UIImageView* touch_view = [[UIImageView alloc] initWithFrame:CGRectMake( 7.0f + look.size.width, fy, touch.size.width, touch.size.height )];
	touch_view.image = touch;
	[content_view addSubview:touch_view];

	fy = fy + look.size.height + fgutter;

	UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 30.0f, frame.size.width - 3.0f, 280.0f) style:UITableViewStyleGrouped];
	tableView.tag = tagTableView;
	tableView.dataSource = self;
	tableView.delegate = self;
	tableView.scrollEnabled = NO;
	[content_view addSubview:tableView];

	[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier];

	fy = fy + 220.0f + 30.0f + fgutter;

	[self.view addSubview:content_view];
}
#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

	cell.accessoryType = UITableViewCellAccessoryNone;

	if(indexPath.row == tableViewRowPelvisElevated && !cell.accessoryView) {
		UISegmentedControl *segment = [[UISegmentedControl alloc] init];
		segment.frame = CGRectMake(0,0,200,30);
		segment.tag   = indexPath.row;
		[segment insertSegmentWithTitle:@"Left" atIndex:0 animated:NO];
		[segment insertSegmentWithTitle:@"Right" atIndex:1 animated:NO];
		[segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];
		cell.accessoryView = segment;
	} else if(indexPath.row == tableViewRowPelvisRotated && !cell.accessoryView) {
		UISegmentedControl *segment = [[UISegmentedControl alloc] init];
		segment.frame = CGRectMake(0,0,200,30);
		segment.tag   = indexPath.row;
		[segment insertSegmentWithTitle:@"Clockwise" atIndex:0 animated:NO];
		[segment insertSegmentWithTitle:@"Counter-Clockwise" atIndex:1 animated:NO];
		[segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];
		cell.accessoryView = segment;
	}

	switch(indexPath.row) {
	case tableViewRowPelvisLevel:
		cell.textLabel.text = @"Level";
		if((PACPelvisBackAlignment & pelvisBackAlignmentLevel) == pelvisBackAlignmentLevel) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewRowPelvisElevated:
		cell.textLabel.text = @"Elevated";
		((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = -1;
		if((PACPelvisBackAlignment & pelvisBackAlignmentElevatedLeft) == pelvisBackAlignmentElevatedLeft) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACPelvisBackAlignment & pelvisBackAlignmentElevatedRight) == pelvisBackAlignmentElevatedRight) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
		}
		break;
	case tableViewRowPelvisRotated:
		cell.textLabel.text = @"Rotated";
		((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = -1;
		if((PACPelvisBackAlignment & pelvisBackAlignmentRotatedClockwise) == pelvisBackAlignmentRotatedClockwise) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACPelvisBackAlignment & pelvisBackAlignmentRotatedCounterClockwise) == pelvisBackAlignmentRotatedCounterClockwise) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
		}
		break;
	}
	return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return tableViewRowCount;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, tableView.frame.size.width, 42.0f)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor blackColor];
	label.font = [UIFont boldSystemFontOfSize:16.0];
	label.text = NSLocalizedString(@"● Palpate each PSIS and compare.\r\n● Palpate top of iliac crests with hands parallel to floor.", @"");
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	return label;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 64.0f;
}
#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.row == tableViewRowPelvisLevel) {
		PACPelvisBackAlignment = pelvisBackAlignmentLevel;
		[tableView reloadData];

		if(!((PACChecklistBackView & backViewCheckListPelvis) == backViewCheckListPelvis)) {
			PACChecklistBackView |= backViewCheckListPelvis;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListBackViewDidChange] object:nil];
		}
	}
}
#pragma mark -
#pragma mark private
-(void) segmentvaluechanged:(id)sender
{
	UISegmentedControl* segment = (UISegmentedControl*)sender;

	if(segment.tag == tableViewRowPelvisElevated) {
		switch(segment.selectedSegmentIndex) {
		case 0: // elevated left
			PACPelvisBackAlignment &= ~pelvisBackAlignmentLevel;
			PACPelvisBackAlignment &= ~pelvisBackAlignmentElevatedRight;
			PACPelvisBackAlignment |= pelvisBackAlignmentElevatedLeft;
			break;
		case 1: // elevated right
			PACPelvisBackAlignment &= ~pelvisBackAlignmentLevel;
			PACPelvisBackAlignment &= ~pelvisBackAlignmentElevatedLeft;
			PACPelvisBackAlignment |= pelvisBackAlignmentElevatedRight;
			break;
		}
	} else if(segment.tag == tableViewRowPelvisRotated) {
		switch(segment.selectedSegmentIndex) {
		case 0: // rotated clockwise
			PACPelvisBackAlignment &= ~pelvisBackAlignmentLevel;
			PACPelvisBackAlignment &= ~pelvisBackAlignmentRotatedCounterClockwise;
			PACPelvisBackAlignment |= pelvisBackAlignmentRotatedClockwise;
			break;
		case 1: // rotated counter-clockwise
			PACPelvisBackAlignment &= ~pelvisBackAlignmentLevel;
			PACPelvisBackAlignment &= ~pelvisBackAlignmentRotatedClockwise;
			PACPelvisBackAlignment |= pelvisBackAlignmentRotatedCounterClockwise;
			break;
		}
	}

	if(PACPelvisBackAlignment > -1) {

		UITableView* tableView = (UITableView*)[[self.view viewWithTag:tagContentView] viewWithTag:tagTableView];
		[tableView reloadData];

		if(!((PACChecklistBackView & backViewCheckListPelvis) == backViewCheckListPelvis)) {
			PACChecklistBackView |= backViewCheckListPelvis;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListBackViewDidChange] object:nil];
		}
	}
}
@end
