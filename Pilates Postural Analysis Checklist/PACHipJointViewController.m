//
//  PACHipJointViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/23/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACHipJointViewController.h"
#import "PACGlobal.h"

enum {
	tagContentView = 100
	, tagTableView
};

enum {
	tableViewRowLeftHip = 0
	, tableViewRowRightHip = 1
	, tableViewRowCount
};

static NSString* cell_identifier = @"hip-joint-cell";

@interface PACHipJointViewController ()
-(void) segmentvaluechanged:(id)sender;
@end

@implementation PACHipJointViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

-(void) loadView
{
	[super loadView];

	self.navigationItem.title = @"Hip Joints";

	CGRect frame = self.view.frame;
	float fy = 5.0f;
	float fgutter = 5.0f;


	UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
	content_view.tag = tagContentView;
	content_view.backgroundColor = [UIColor whiteColor];

	UIImage* image = [UIImage imageNamed:@"hipjoint_detail.png"];

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

	UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 15.0f, frame.size.width - 3.0f, 220.0f) style:UITableViewStyleGrouped];
	tableView.tag = tagTableView;
	tableView.dataSource = self;
	tableView.delegate = self;
	tableView.scrollEnabled = NO;
	[content_view addSubview:tableView];

	[tableView registerClass:[UITableViewCell class ] forCellReuseIdentifier:cell_identifier];

	fy = fy + 220.0f + 30.0f + fgutter;


	[self.view addSubview:content_view];


}
#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 /*UITableViewCellStyleDefault*/ reuseIdentifier:cell_identifier];
		cell.accessoryView = nil;
	}

	if(!cell.accessoryView) {
		UISegmentedControl *segment = [[UISegmentedControl alloc] init];
		segment.frame = CGRectMake(0,0,260,30);
		segment.tag   = indexPath.row;
		[segment insertSegmentWithTitle:@"Neutral" atIndex:0 animated:NO];
		[segment insertSegmentWithTitle:@"Extended" atIndex:1 animated:NO];
		[segment insertSegmentWithTitle:@"Flexed"  atIndex:2 animated:NO];
		[segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];

		cell.accessoryView = segment;
	}

	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];

	switch(indexPath.row) {
	case tableViewRowLeftHip:
		cell.textLabel.text = @"Left Hip";
		((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = PACHipAlignmentLeft;
		break;
	case tableViewRowRightHip:
		cell.textLabel.text = @"Right Hip";
		((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = PACHipAlignmentRight;
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
	UIView* res = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 63.0f)];

	res.backgroundColor = [UIColor clearColor];

	UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, tableView.frame.size.width, 42.0f)];
	label1.backgroundColor = [UIColor clearColor];
	label1.textColor = [UIColor blackColor];
	label1.font = [UIFont boldSystemFontOfSize:16.0];
	label1.text = NSLocalizedString(@"●Palpate ASIS and PSIS to find the midpoint of the iliac crest.", @"");
	label1.numberOfLines = 0;
	label1.lineBreakMode = NSLineBreakByWordWrapping;
	[res addSubview:label1];

	UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 46.0f, tableView.frame.size.width, 21.0f)];
	label2.backgroundColor = [UIColor clearColor];
	label2.textColor = [UIColor blackColor];
	label2.font = [UIFont boldSystemFontOfSize:16.0];
	label2.text = NSLocalizedString(@"●Palpate greater trochanter and compare.", @"");
	label2.numberOfLines = 0;
	label2.lineBreakMode = NSLineBreakByWordWrapping;
	[res addSubview:label2];


	return res;

}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 68.0f;
}
#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark -
-(void) segmentvaluechanged:(id)sender
{

	UISegmentedControl *segment = (UISegmentedControl*)sender;

	switch(segment.tag) {
	case tableViewRowLeftHip:
		PACHipAlignmentLeft = (int)segment.selectedSegmentIndex;
		break;
	case tableViewRowRightHip:
		PACHipAlignmentRight = (int)segment.selectedSegmentIndex;
		break;
	}

	if(PACHipAlignmentRight > -1 && PACHipAlignmentLeft > -1) {
		if(!((PACChecklistSideView & sideViewCheckListHipJoint) == sideViewCheckListHipJoint)) {
			PACChecklistSideView |= sideViewCheckListHipJoint;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListSideViewDidChange] object:nil];
		}
	} else {
		if((PACChecklistSideView & sideViewCheckListHipJoint) == sideViewCheckListHipJoint) {
			PACChecklistSideView &= ~sideViewCheckListHipJoint;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListSideViewDidChange] object:nil];
		}

	}
}
@end
