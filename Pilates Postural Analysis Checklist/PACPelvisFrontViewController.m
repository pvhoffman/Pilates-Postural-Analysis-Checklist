//
//  PACPelvisFrontViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/6/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACPelvisFrontViewController.h"
#import "PACGlobal.h"

enum {
	tagContentView = 100
	, tagTableView
};

enum {
	tableViewRowPelvisLevel = 0
	, tableViewRowPelvisElevatedLeft = 1
	, tableViewRowPelvisElevatedRight = 2
	, tableViewRowPelvisRotatedClockwise = 3
	, tableViewRowPelvisRotatedCounterClockwise = 4
	, tableViewRowCount = 5
};

static NSString* cell_identifier = @"pelvis-front-cell";

@interface PACPelvisFrontTableViewCell : UITableViewCell
@end

@implementation PACPelvisFrontTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end

@interface PACPelvisFrontViewController ()
@end

@implementation PACPelvisFrontViewController

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

	self.navigationItem.title = @"Pelvis - Front";

	CGRect frame = self.view.frame;
	float fy = 5.0f;
	float fgutter = 5.0f;


	UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
	content_view.tag = tagContentView;
	content_view.backgroundColor = [UIColor whiteColor];

	UIImage* image = [UIImage imageNamed:@"pelvis_front_detail.gif"];

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

	UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 30.0f, frame.size.width - 3.0f, 220.0f) style:UITableViewStyleGrouped];
	tableView.tag = tagTableView;
	tableView.dataSource = self;
	tableView.delegate = self;
	tableView.scrollEnabled = NO;
	[content_view addSubview:tableView];

	[tableView registerClass:[PACPelvisFrontTableViewCell class ] forCellReuseIdentifier:cell_identifier];

	fy = fy + 220.0f + 30.0f + fgutter;

	[self.view addSubview:content_view];
}
#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	PACPelvisFrontTableViewCell* cell = (PACPelvisFrontTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

	switch(indexPath.row) {
	case pelvisFrontAlignmentLevel:
		cell.textLabel.text = @"Level";
		break;
	case pelvisFrontAlignmentElevatedLeft:
		cell.textLabel.text = @"Left Elevated";
		break;
	case pelvisFrontAlignmentElevatedRight:
		cell.textLabel.text = @"Right Elevated";
		break;
	case pelvisFrontAlignmentRotatedClockwise:
		cell.textLabel.text = @"Rotated Clockwise";
		break;
	case pelvisFrontAlignmentRotatedCounterClockwise:
		cell.textLabel.text = @"Rotated Counter-Clockwise";
		break;

	}

	cell.accessoryType = ((indexPath.row == PACPelvisFrontAlignment) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);

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
	label.text = NSLocalizedString(@"● Palpate each ASIS and compare. Palpate top of iliac crests with hands parallel to floor.", @"");
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
	PACPelvisFrontAlignment = (int)indexPath.row;
	[tableView reloadData];

	if(!((PACChecklistFrontView & frontViewCheckListPelvis) == frontViewCheckListPelvis)) {
		PACChecklistFrontView |= frontViewCheckListPelvis;
		[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
	}
}
@end
