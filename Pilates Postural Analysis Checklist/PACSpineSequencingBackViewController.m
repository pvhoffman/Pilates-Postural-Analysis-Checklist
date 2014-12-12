//
//  PACSpineSequencingBackViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/2/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACSpineSequencingBackViewController.h"
#import "PACGlobal.h"

enum {
	tagContentView = 100
	, tagTableView
	, tagTableViewFlatAreas
	, tagTableViewImbalances
};


enum {
	tableViewSectionCount = 1
};

enum {
	tableViewMainRowFlatAreas        = 0
	, tableViewMainRowImbalances = 1
	, tableViewMainRowCount      = 2
};

enum {
	tableViewFlatAreasRowUpperNone           = 0
	, tableViewFlatAreasRowUpperCervical = 1
	, tableViewFlatAreasRowLowerCervical = 2
	, tableViewFlatAreasRowUpperThoracic = 3
	, tableViewFlatAreasRowLowerThoracic = 4
	, tableViewFlatAreasRowUpperLumbar   = 5
	, tableViewFlatAreasRowLowerLumbar   = 6
	, tableViewFlatAreasRowCount         = 7
};

#if 0
enum {
	tableViewImbalancesRowNone            = 0
	, tableViewImbalancesRowHead      = 1
	, tableViewImbalancesRowShoulders = 2
	, tableViewImbalancesRowPelvis    = 3
	, tableViewImbalancesRowKnees     = 4
	, tableViewImbalancesRowAnkles    = 5
	, tableViewImbalancesRowCount     = 6
};
#else

enum {
	tableViewImbalanceRowNone                     = 0
	, tableViewImbalanceRowUpperScapulaeLeft  = 1
	, tableViewImbalanceRowUpperScapulaeRight = 2
	, tableViewImbalanceRowLowerScapulaeLeft  = 3
	, tableViewImbalanceRowLowerScapulaeRight = 4
	, tableViewImbalanceRowLumbarLeft         = 5
	, tableViewImbalanceRowLumbarRight        = 6
	, tableViewImbalancesRowCount             = 7
};

#endif

static NSString* cell_identifier            = @"spinesequencing-back-cell";
static NSString* cell_identifier_flatareas  = @"spinesequencing-back-cell-flatareas";
static NSString* cell_identifier_imbalances = @"spinesequencing-back-cell-imbalances";

//-----------------------------------------------------------------------------
@interface PACSpineFlatAreaTableViewCell : UITableViewCell
@end

@implementation PACSpineFlatAreaTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------
@interface PACSpineSequencingBackViewController ()
- (UITableViewCell *)cellForRowAtIndexPathMain:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForRowAtIndexPathFlatAreas:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForRowAtIndexPathImbalances:(UITableView*)tableView at:(NSIndexPath*)indexPath;

- (NSInteger) numberOfRowsInSectionMain:(NSInteger)section;
- (NSInteger) numberOfRowsInSectionFlatAreas:(NSInteger)section;
- (NSInteger) numberOfRowsInSectionImbalances:(NSInteger)section;

- (void) didSelectRowAtIndexPathMain:(UITableView*)tableView at:(NSIndexPath *)indexPath;
- (void) didSelectRowAtIndexPathFlatAreas:(UITableView*)tableView at:(NSIndexPath *)indexPath;
- (void) didSelectRowAtIndexPathImbalances:(UITableView*)tableView at:(NSIndexPath *)indexPath;

- (UIView *) viewForHeaderInSectionMain:(NSInteger)section;
- (UIView *) viewForHeaderInSectionFlatAreas:(NSInteger)section;
- (UIView *) viewForHeaderInSectionImbalances:(NSInteger)section;

-(void) doneButtonClicked:(id)sender;
@end

@implementation PACSpineSequencingBackViewController

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

	self.navigationItem.title = @"Sequencing through the spine";

	CGRect frame = self.view.frame;
	float fy = 5.0f;
	float fgutter = 5.0f;


	UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
	content_view.tag = tagContentView;
	content_view.backgroundColor = [UIColor whiteColor];

	UIImage* image = [UIImage imageNamed:@"spine_sequencing.jpg"];

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

	UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 30.0f, frame.size.width - 3.0f, 227.0f) style:UITableViewStyleGrouped];
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
- (UITableViewCell *)cellForRowAtIndexPathMain:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;// UITableViewCellAccessoryNone;
	switch(indexPath.row) {
	case tableViewMainRowFlatAreas:
		cell.textLabel.text = @"Flat Areas";
		if(PACSpineSequencing) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewMainRowImbalances:
		cell.textLabel.text = @"Imbalances";
		if(PACSpineImbalance) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	}
	return cell;
}
- (UITableViewCell *)cellForRowAtIndexPathFlatAreas:(UITableView*)tableView at:(NSIndexPath*)indexPath
{

	PACSpineFlatAreaTableViewCell* cell = (PACSpineFlatAreaTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier_flatareas forIndexPath:indexPath];

	cell.accessoryType = UITableViewCellAccessoryNone;

	switch(indexPath.row) {
	case tableViewFlatAreasRowUpperNone:
		cell.textLabel.text = @"None";
		if(PACSpineSequencing == spineSequencingNone) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewFlatAreasRowUpperCervical:
		cell.textLabel.text = @"Upper Cervical";
		cell.detailTextLabel.text = @"C1 - C4";
		if((PACSpineSequencing & spineSequencingUpperCervical) == spineSequencingUpperCervical) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewFlatAreasRowLowerCervical:
		cell.textLabel.text = @"Lower Cervical";
		cell.detailTextLabel.text = @"C4 - C7";
		if((PACSpineSequencing & spineSequencingLowerCervical) == spineSequencingLowerCervical) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewFlatAreasRowUpperThoracic:
		cell.textLabel.text = @"Upper Thoracic";
		cell.detailTextLabel.text = @"T1 - T6";
		if((PACSpineSequencing & spineSequencingUpperThoracic) == spineSequencingUpperThoracic) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewFlatAreasRowLowerThoracic:
		cell.textLabel.text = @"Lower Thoracic";
		cell.detailTextLabel.text = @"T6 - T12";
		if((PACSpineSequencing & spineSequencingLowerThoracic) == spineSequencingLowerThoracic) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewFlatAreasRowUpperLumbar:
		cell.textLabel.text = @"Upper Lumbar";
		cell.detailTextLabel.text = @"L1 - L3";
		if((PACSpineSequencing & spineSequencingUpperLumbar) == spineSequencingUpperLumbar) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewFlatAreasRowLowerLumbar:
		cell.textLabel.text = @"Lower Lumbar";
		cell.detailTextLabel.text = @"L3 - L5";
		if((PACSpineSequencing & spineSequencingLowerLumbar) == spineSequencingLowerLumbar) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	}
	return cell;

}
- (UITableViewCell *)cellForRowAtIndexPathImbalances:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier_imbalances forIndexPath:indexPath];

	cell.accessoryType = UITableViewCellAccessoryNone;
	switch(indexPath.row) {
	case tableViewImbalanceRowNone:
		cell.textLabel.text = @"None";
		if(PACSpineImbalance == spineImbalanceNone) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewImbalanceRowUpperScapulaeLeft:
		cell.textLabel.text = @"Upper/Left Scapulae";
		if((PACSpineImbalance & spineImbalanceUpperScapulaeLeft) == spineImbalanceUpperScapulaeLeft) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewImbalanceRowUpperScapulaeRight:
		cell.textLabel.text = @"Upper/Right Scapulae";
		if((PACSpineImbalance & spineImbalanceUpperScapulaeRight) == spineImbalanceUpperScapulaeRight) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewImbalanceRowLowerScapulaeLeft:
		cell.textLabel.text = @"Lower/Left Scapulae";
		if((PACSpineImbalance & spineImbalanceLowerScapulaeLeft) == spineImbalanceLowerScapulaeLeft) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewImbalanceRowLowerScapulaeRight:
		cell.textLabel.text = @"Lower/Right Scapulae";
		if((PACSpineImbalance & spineImbalanceLowerScapulaeRight) == spineImbalanceLowerScapulaeRight) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewImbalanceRowLumbarLeft:
		cell.textLabel.text = @"Left Lumbar";
		if((PACSpineImbalance & spineImbalanceLumbarLeft) == spineImbalanceLumbarLeft) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	case tableViewImbalanceRowLumbarRight:
		cell.textLabel.text = @"Right Lumbar";
		if((PACSpineImbalance & spineImbalanceLumbarRight) == spineImbalanceLumbarRight) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		break;
	}
	return cell;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch(tableView.tag) {
	case tagTableView:
		return [self cellForRowAtIndexPathMain:tableView at:indexPath];
	case tagTableViewFlatAreas:
		return [self cellForRowAtIndexPathFlatAreas:tableView at:indexPath];
	case tagTableViewImbalances:
		return [self cellForRowAtIndexPathImbalances:tableView at:indexPath];
	}
	return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return tableViewSectionCount;
}
- (NSInteger) numberOfRowsInSectionMain:(NSInteger)section
{
	return tableViewMainRowCount;
}
- (NSInteger) numberOfRowsInSectionFlatAreas:(NSInteger)section
{
	return tableViewFlatAreasRowCount;
}
- (NSInteger) numberOfRowsInSectionImbalances:(NSInteger)section
{
	return tableViewImbalancesRowCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch(tableView.tag) {
	case tagTableView:
		return [self numberOfRowsInSectionMain:section];
	case tagTableViewFlatAreas:
		return [self numberOfRowsInSectionFlatAreas:section];
	case tagTableViewImbalances:
		return [self numberOfRowsInSectionImbalances:section];
	}
	return 0;
}
- (UIView *) viewForHeaderInSectionMain:(NSInteger)section
{
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, self.view.frame.size.width, 64.0f)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor blackColor];
	label.font = [UIFont boldSystemFontOfSize:16.0];
	label.text = NSLocalizedString(@"● Palpate either side of spine and feel for any irregular curvature, rotation or imbalances.", @"");
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	return label;

}
- (UIView *) viewForHeaderInSectionFlatAreas:(NSInteger)section
{
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, self.view.frame.size.width, 38.0f)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor blackColor];
	label.font = [UIFont boldSystemFontOfSize:16.0];
	label.text = NSLocalizedString(@"● Watch from the side for flat areas in the spine.", @"");
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	return label;

}
- (UIView *) viewForHeaderInSectionImbalances:(NSInteger)section
{
	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, self.view.frame.size.width, 38.0f)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor blackColor];
	label.font = [UIFont boldSystemFontOfSize:16.0];
	label.text = NSLocalizedString(@"● Watch and palpate from the back.", @"");
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	return label;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	switch(tableView.tag) {
	case tagTableView:
		return [self viewForHeaderInSectionMain:section];
	case tagTableViewFlatAreas:
		return [self viewForHeaderInSectionFlatAreas:section];
	case tagTableViewImbalances:
		return [self viewForHeaderInSectionImbalances:section];
	}
	return nil;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	switch(tableView.tag) {
	case tagTableView:
		return 64.0f;
	case tagTableViewFlatAreas:
	case tagTableViewImbalances:
		return 38.0f;
	}
	return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	CGFloat res = 0.0f;
	switch(tableView.tag) {
	case tagTableViewFlatAreas:
	case tagTableViewImbalances:
		res = 37.0f;
	}
	return res;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	if(tableView.tag == tagTableViewFlatAreas || tableView.tag == tagTableViewImbalances) {
		UIButton* button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		button1.frame = CGRectMake((tableView.frame.size.width / 2.0f) - (200.0f / 2.0f), 21.0f, 200.0f, 37.0f);
		button1.tag = tableView.tag;
		[button1 setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
		[button1 addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		return button1;
	}

	return nil;


}
#pragma mark -
#pragma mark UITableViewDelegate
- (void) didSelectRowAtIndexPathMain:(UITableView*)tableView at:(NSIndexPath *)indexPath
{
	UITableView* table_view = [[UITableView alloc] initWithFrame:tableView.frame style:UITableViewStyleGrouped];
	table_view.scrollEnabled = YES;
	table_view.dataSource = self;
	table_view.delegate   = self;


	switch(indexPath.row) {
	case tableViewMainRowFlatAreas:
		table_view.tag = tagTableViewFlatAreas;
		[table_view registerClass:[PACSpineFlatAreaTableViewCell class] forCellReuseIdentifier:cell_identifier_flatareas];
		break;
	case tableViewMainRowImbalances:
		table_view.tag = tagTableViewImbalances;
		[table_view registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier_imbalances];
		break;
	}

	[UIView transitionFromView:tableView toView:table_view duration:0.45 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){}];
}
- (void) didSelectRowAtIndexPathFlatAreas:(UITableView*)tableView at:(NSIndexPath *)indexPath
{
	if(indexPath.row == tableViewFlatAreasRowUpperNone) {
		PACSpineSequencing = spineSequencingNone;
	} else {
		PACSpineSequencing &= ~spineSequencingNone;
		PACSpineSequencing |= (1 << indexPath.row);
	}
	[tableView reloadData];
}
- (void) didSelectRowAtIndexPathImbalances:(UITableView*)tableView at:(NSIndexPath *)indexPath
{
	if(indexPath.row == tableViewImbalanceRowNone) {
		PACSpineImbalance = spineImbalanceNone;
	} else {
		PACSpineImbalance &= ~spineImbalanceNone;
		PACSpineImbalance |= (1 << indexPath.row);
	}
	[tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch(tableView.tag) {
	case tagTableView:
		return [self didSelectRowAtIndexPathMain:tableView at:indexPath];
	case tagTableViewFlatAreas:
		return [self didSelectRowAtIndexPathFlatAreas:tableView at:indexPath];
	case tagTableViewImbalances:
		return [self didSelectRowAtIndexPathImbalances:tableView at:indexPath];
	}
}
-(void) doneButtonClicked:(id)sender
{
	UIButton* button = (UIButton*)sender;
	UITableView* tableView = (UITableView*)[self.view viewWithTag:button.tag];

	UITableView* table_view  = [[UITableView alloc] initWithFrame:tableView.frame style:UITableViewStyleGrouped];
	table_view.scrollEnabled = YES;
	table_view.dataSource    = self;
	table_view.delegate      = self;
	table_view.tag           = tagTableView;
	[table_view registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier];

	[UIView transitionFromView:tableView toView:table_view duration:0.45 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished){}];

	if(PACSpineImbalance && PACSpineSequencing) {
		if(!((PACChecklistBackView & backViewCheckListSpineSequencing) == backViewCheckListSpineSequencing)) {
			PACChecklistBackView |= backViewCheckListSpineSequencing;
			[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListBackViewDidChange] object:nil];
		}
	}
}
@end

