//
//  PACHeadFrontViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/6/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACHeadFrontViewController.h"
#import "PACGlobal.h"

enum {
	tagContentView = 100
	, tagTableView
};

enum {
	tableViewRowHeadNeutral = 0
	, tableViewRowHeadRotatedClockwise
	, tableViewRowHeadRotatedCounterClockwise
	, tableViewRowHeadTilted
	, tableViewRowHeadShifted
	, tableViewRowCount
};

static NSString* cell_identifier = @"head-front-cell";

@interface PACHeadFrontViewController ()
-(void) segmentvaluechanged:(id)sender;
@end

@implementation PACHeadFrontViewController

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

	self.navigationItem.title = @"Head - Front";

	CGRect frame = self.view.frame;
	float fy = 5.0f;
	float fgutter = 5.0f;


	UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
	content_view.tag = tagContentView;
	content_view.backgroundColor = [UIColor whiteColor];

	UIImage* image = [UIImage imageNamed:@"head_front_detail.jpg"];

	UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake( (frame.size.width / 2.0f) - (image.size.width / 2.0f), fy, image.size.width, image.size.height)];
	image_view.image = image;
	[content_view addSubview:image_view];

	fy = fy + image.size.height + fgutter;

	UIImage* look = [UIImage imageNamed:@"look.jpg"];
	UIImageView* look_view = [[UIImageView alloc] initWithFrame:CGRectMake( 5.0f, fy, look.size.width, look.size.height )];
	look_view.image = look;
	[content_view addSubview:look_view];

	fy = fy + look.size.height + fgutter;

	UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 30.0f, frame.size.width - 3.0f, 250.0f) style:UITableViewStyleGrouped];
	tableView.tag = tagTableView;
	tableView.dataSource = self;
	tableView.delegate = self;
	tableView.scrollEnabled = YES;
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

	// tilted and shifted have a left/right option
	if(indexPath.row == tableViewRowHeadTilted || indexPath.row == tableViewRowHeadShifted) {
		if(!cell.accessoryView) {
			UISegmentedControl *segment = [[UISegmentedControl alloc] init];
			segment.frame = CGRectMake(0,0,200,30);
			segment.tag   = indexPath.row;
			[segment insertSegmentWithTitle:@"Left" atIndex:0 animated:NO];
			[segment insertSegmentWithTitle:@"Right" atIndex:1 animated:NO];
			[segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];

			cell.accessoryView = segment;
		}

	} else {
		cell.accessoryView = nil;
	}

	cell.accessoryType = UITableViewCellAccessoryNone;

	switch(indexPath.row) {
	case tableViewRowHeadNeutral:
		cell.textLabel.text = @"Neutral";
		if(PACHeadFrontAlignment == headFrontAlignmentNeutral) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewRowHeadRotatedClockwise:
		cell.textLabel.text = @"Rotated Clockwise";
		if((PACHeadFrontAlignment & headFrontAlignmentRotatedClockwise) == headFrontAlignmentRotatedClockwise) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewRowHeadRotatedCounterClockwise:
		cell.textLabel.text = @"Rotated Counter-Clockwise";
		if((PACHeadFrontAlignment & headFrontAlignmentRotatedCounterClockwise) == headFrontAlignmentRotatedCounterClockwise) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewRowHeadTilted:
		cell.textLabel.text = @"Tilted";
		((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = -1;
		if((PACHeadFrontAlignment & headFrontAlignmentTiltedLeft) == headFrontAlignmentTiltedLeft) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACHeadFrontAlignment & headFrontAlignmentTiltedRight) == headFrontAlignmentTiltedRight) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
		}
		break;
	case tableViewRowHeadShifted:
		cell.textLabel.text = @"Shifted";
		((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = -1;
		if((PACHeadFrontAlignment & headFrontAlignmentShiftedLeft) == headFrontAlignmentShiftedLeft) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACHeadFrontAlignment & headFrontAlignmentShiftedRight) == headFrontAlignmentShiftedRight) {
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
	label.text = NSLocalizedString(@"● Examine alignment of cranium on cervical spine.", @"");
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	return label;

}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 44.0f;
}
#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL reload = NO;
	switch(indexPath.row) {
	case tableViewRowHeadNeutral:
		PACHeadFrontAlignment = headFrontAlignmentNeutral;
		reload = YES;
		break;
	case tableViewRowHeadRotatedClockwise:
		PACHeadFrontAlignment &= ~headFrontAlignmentNeutral;
		PACHeadFrontAlignment &= ~headFrontAlignmentRotatedCounterClockwise;
		PACHeadFrontAlignment |=  headFrontAlignmentRotatedClockwise;
		reload = YES;
		break;
	case tableViewRowHeadRotatedCounterClockwise:
		PACHeadFrontAlignment &= ~headFrontAlignmentNeutral;
		PACHeadFrontAlignment &= ~headFrontAlignmentRotatedClockwise;
		PACHeadFrontAlignment |=  headFrontAlignmentRotatedCounterClockwise;
		reload = YES;
		break;
	}
	if(reload == YES) {
		[tableView reloadData];
		if(!((PACChecklistFrontView & frontViewCheckListHead) == frontViewCheckListHead)) {
			PACChecklistFrontView |= frontViewCheckListHead;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
		}
	}
}
-(void) segmentvaluechanged:(id)sender
{
	BOOL reload = NO;
	UISegmentedControl* segment = (UISegmentedControl*)sender;

	if(segment.tag == tableViewRowHeadTilted) {
		switch(segment.selectedSegmentIndex) {
		case 0: // left
			PACHeadFrontAlignment &= ~headFrontAlignmentNeutral;
			PACHeadFrontAlignment &= ~headFrontAlignmentTiltedRight;
			PACHeadFrontAlignment |=  headFrontAlignmentTiltedLeft;
			break;
		case 1: // right
			PACHeadFrontAlignment &= ~headFrontAlignmentNeutral;
			PACHeadFrontAlignment &= ~headFrontAlignmentTiltedLeft;
			PACHeadFrontAlignment |=  headFrontAlignmentTiltedRight;
			break;
		}
		reload = YES;
	} else if(segment.tag == tableViewRowHeadShifted) {
		switch(segment.selectedSegmentIndex) {
		case 0: // left
			PACHeadFrontAlignment &= ~headFrontAlignmentNeutral;
			PACHeadFrontAlignment &= ~headFrontAlignmentShiftedRight;
			PACHeadFrontAlignment |=  headFrontAlignmentShiftedLeft;
			break;
		case 1: // right
			PACHeadFrontAlignment &= ~headFrontAlignmentNeutral;
			PACHeadFrontAlignment &= ~headFrontAlignmentShiftedLeft;
			PACHeadFrontAlignment |=  headFrontAlignmentShiftedRight;
			break;
		}
		reload = YES;
	}


	if(reload == YES) {
		UITableView* tableView = (UITableView*)[[self.view viewWithTag:tagContentView] viewWithTag:tagTableView];
		[tableView reloadData];
		if(!((PACChecklistFrontView & frontViewCheckListHead) == frontViewCheckListHead)) {
			PACChecklistFrontView |= frontViewCheckListHead;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
		}
	}
}

@end
