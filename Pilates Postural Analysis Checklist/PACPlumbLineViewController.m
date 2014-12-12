//
//  PACPlumbLineViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/22/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACPlumbLineViewController.h"
#import "PACGlobal.h"

enum {
	tagContentView = 100
	, tagTableView
};

enum {
	tableViewRowHead                    = 0
	, tableViewRowShoulders         = 1
	, tableViewRowUpperBody         = 2
	, tableViewRowPelvis            = 3
	, tableViewRowKnees             = 4
	, tableViewRowRelativeAlignment = 5
	, tableViewRowCount             = 6
};

static NSString* cell_identifier = @"plumbline-cell";
//-----------------------------------------------------------------------------
@interface PACPlumbLineTableViewCell : UITableViewCell
@end
@implementation PACPlumbLineTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
	return self;
}
@end
//-----------------------------------------------------------------------------
@interface PACPlumbLineViewController ()
-(void) segmentvaluechanged:(id)sender;
-(void) clearAllButtonClicked:(id)sender;
-(void) switchvaluechanged:(id)sender;
@end

@implementation PACPlumbLineViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void) loadView
{
	[super loadView];

	self.navigationItem.title = @"Plumb Line";//[detailItem description];

	CGRect frame = self.view.frame;
	UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
	content_view.tag = tagContentView;
	content_view.backgroundColor = [UIColor whiteColor];

	UIImage* image = [UIImage imageNamed:@"plumbline_detail.gif"];

	UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width / 2.0f) - (image.size.width / 2.0f), 5.0, image.size.width, image.size.height)];
	image_view.image = image;
	[content_view addSubview:image_view];

	UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, image.size.height - 32.0f, frame.size.width - 3.0f, frame.size.height - image.size.height + 20.0f) style:UITableViewStyleGrouped];
	tableView.tag = tagTableView;
	tableView.dataSource = self;
	tableView.delegate = self;
        tableView.scrollEnabled = NO;

	[tableView registerClass:[PACPlumbLineTableViewCell class ] forCellReuseIdentifier:cell_identifier];
	//tableView.tag = tagTableView;
	[content_view addSubview:tableView];


	[self.view addSubview:content_view];


}
- (void)didReceiveMemoryWarning
{
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


#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	PACPlumbLineTableViewCell* cell = (PACPlumbLineTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

	if(!cell.accessoryView) {
		if(indexPath.row == tableViewRowRelativeAlignment) {
			UISwitch* sitch = [[UISwitch alloc] init];
			sitch.frame = CGRectMake(0.0f, 0.0f, 60.0f, 21.0f);
			sitch.tag   = indexPath.row;
			[sitch addTarget:self action:@selector(switchvaluechanged:) forControlEvents:UIControlEventValueChanged];
			cell.accessoryView = sitch;
		} else {
			UISegmentedControl *segment = [[UISegmentedControl alloc] init];
			segment.frame = CGRectMake(0,0,170,30);
			segment.tag   = indexPath.row;
			[segment insertSegmentWithTitle:@"Forward" atIndex:0 animated:NO];
			[segment insertSegmentWithTitle:@"Aligned" atIndex:1 animated:NO];
			[segment insertSegmentWithTitle:@"Behind"  atIndex:2 animated:NO];
			[segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];

			cell.accessoryView = segment;
		}
	}

	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];

	if(indexPath.row != tableViewRowRelativeAlignment) {
		((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = -1;
	}

	switch(indexPath.row) {
	case tableViewRowHead:
		cell.textLabel.text = @"Head";
		if((PACPlumbLineAlignment & plumbHeadForward) == plumbHeadForward) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACPlumbLineAlignment & plumbHeadAligned) == plumbHeadAligned) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
		} else if((PACPlumbLineAlignment & plumbHeadBehind) == plumbHeadBehind) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 2;
		}
		break;
	case tableViewRowShoulders:
		cell.textLabel.text = @"Shoulders";
		if((PACPlumbLineAlignment & plumbShouldersForward) == plumbShouldersForward) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACPlumbLineAlignment & plumbShouldersAligned) == plumbShouldersAligned) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
		} else if((PACPlumbLineAlignment & plumbShouldersBehind) == plumbShouldersBehind) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 2;
		}
		break;
	case tableViewRowUpperBody:
		cell.textLabel.text = @"Upper Body";
		if((PACPlumbLineAlignment & plumbUpperBodyForward) == plumbUpperBodyForward) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACPlumbLineAlignment & plumbUpperBodyAligned) == plumbUpperBodyAligned) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
		} else if((PACPlumbLineAlignment & plumbUpperBodyBehind) == plumbUpperBodyBehind) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 2;
		}
		break;
	case tableViewRowPelvis:
		cell.textLabel.text = @"Pelvis";
		if((PACPlumbLineAlignment & plumbPelvisForward) == plumbPelvisForward) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACPlumbLineAlignment & plumbPelvisAligned) == plumbPelvisAligned) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
		} else if((PACPlumbLineAlignment & plumbPelvisBehind) == plumbPelvisBehind) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 2;
		}
		break;
	case tableViewRowKnees:
		cell.textLabel.text = @"Knees";
		if((PACPlumbLineAlignment & plumbKneesForward) == plumbKneesForward) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
		} else if((PACPlumbLineAlignment & plumbKneesAligned) == plumbKneesAligned) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
		} else if((PACPlumbLineAlignment & plumbKneesBehind) == plumbKneesBehind) {
			((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 2;
		}
		break;
	case tableViewRowRelativeAlignment:
		cell.textLabel.text = @"Relative Alignment";
		cell.detailTextLabel.text = @"Are the head, thorax and pelvic relatively aligned?";
	        ((UISwitch*)cell.accessoryView).on = ((PACPlumbLineAlignment & plumbRelativeAlign) == plumbRelativeAlign);//((PACChecklistMain & mainChecklistAlignedInRelation) == mainChecklistAlignedInRelation);
		break;
	default:
		cell.textLabel.text = [NSString stringWithFormat:@"cell %d", (int)indexPath.row];
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
	label.text = NSLocalizedString(@"Are parts of the body forward or behind the plumb line?", @"");
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;
	return label;

}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 44.0f;
}
/*
   - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
   {
    UIButton* button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.frame = CGRectMake((tableView.frame.size.width / 2.0f) - (200.0f / 2.0f), 21.0f, 200.0f, 37.0f);
    [button1 setTitle:NSLocalizedString(@"Clear All", @"") forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clearAllButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    return button1;


   }
   -(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
   {
        return 30.0f;
   }
 */
#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark -
-(void) clearAllButtonClicked:(id)sender
{
	PACPlumbLineAlignment = 0;
	PACChecklistMain &= ~mainChecklistPlumbline;

	UIScrollView* scrollView = (UIScrollView*)[self.view viewWithTag:tagContentView];
	UITableView* tableView = (UITableView*)[scrollView viewWithTag:tagTableView];

	[tableView reloadData];

	[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];




}
-(void) switchvaluechanged:(id)sender
{
	UISwitch* s = (UISwitch*)sender;

	if(s.on) {
		PACChecklistMain |= mainChecklistAlignedInRelation;
                PACPlumbLineAlignment |= plumbRelativeAlign;

                if( ((PACPlumbLineAlignment & plumbHeadForward) == plumbHeadForward
                            || (PACPlumbLineAlignment & plumbHeadAligned) == plumbHeadAligned
                            || (PACPlumbLineAlignment & plumbHeadBehind) == plumbHeadBehind)
                        && ((PACPlumbLineAlignment & plumbShouldersForward) == plumbShouldersForward
                            || (PACPlumbLineAlignment & plumbShouldersAligned) == plumbShouldersAligned
                            || (PACPlumbLineAlignment & plumbShouldersBehind) == plumbShouldersBehind)
                        && ((PACPlumbLineAlignment & plumbUpperBodyForward) == plumbUpperBodyForward
                            || (PACPlumbLineAlignment & plumbUpperBodyAligned) == plumbUpperBodyAligned
                            || (PACPlumbLineAlignment & plumbUpperBodyBehind) == plumbUpperBodyBehind)
                        && ((PACPlumbLineAlignment & plumbPelvisForward) == plumbPelvisForward
                            || (PACPlumbLineAlignment & plumbPelvisAligned) == plumbPelvisAligned
                            || (PACPlumbLineAlignment & plumbPelvisBehind) == plumbPelvisBehind)
                        && ((PACPlumbLineAlignment & plumbKneesForward) == plumbKneesForward
                            || (PACPlumbLineAlignment & plumbKneesAligned) == plumbKneesAligned
                            || (PACPlumbLineAlignment & plumbKneesBehind) == plumbKneesBehind) 
                        && ((PACPlumbLineAlignment & plumbRelativeAlign) == plumbRelativeAlign) ) {
                    PACChecklistMain |= mainChecklistPlumbline;
                }

	} else {
		PACChecklistMain &= ~mainChecklistAlignedInRelation;
                PACPlumbLineAlignment &= ~plumbRelativeAlign;
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];
}
-(void) segmentvaluechanged:(id)sender
{
	UISegmentedControl* segment = (UISegmentedControl*)sender;

	switch(segment.tag) {
	case tableViewRowHead:
		PACPlumbLineAlignment &= ~plumbHeadForward;
		PACPlumbLineAlignment &= ~plumbHeadAligned;
		PACPlumbLineAlignment &= ~plumbHeadBehind;
		switch(segment.selectedSegmentIndex) {
		case 0:
			PACPlumbLineAlignment |= plumbHeadForward;
			break;
		case 1:
			PACPlumbLineAlignment |= plumbHeadAligned;
			break;
		case 2:
			PACPlumbLineAlignment |= plumbHeadBehind;
			break;
		}
		break;
	case tableViewRowShoulders:
		PACPlumbLineAlignment &= ~plumbShouldersForward;
		PACPlumbLineAlignment &= ~plumbShouldersAligned;
		PACPlumbLineAlignment &= ~plumbShouldersBehind;
		switch(segment.selectedSegmentIndex) {
		case 0:
			PACPlumbLineAlignment |= plumbShouldersForward;
			break;
		case 1:
			PACPlumbLineAlignment |= plumbShouldersAligned;
			break;
		case 2:
			PACPlumbLineAlignment |= plumbShouldersBehind;
			break;
		}
		break;
	case tableViewRowUpperBody:
		PACPlumbLineAlignment &= ~plumbUpperBodyForward;
		PACPlumbLineAlignment &= ~plumbUpperBodyAligned;
		PACPlumbLineAlignment &= ~plumbUpperBodyBehind;
		switch(segment.selectedSegmentIndex) {
		case 0:
			PACPlumbLineAlignment |= plumbUpperBodyForward;
			break;
		case 1:
			PACPlumbLineAlignment |= plumbUpperBodyAligned;
			break;
		case 2:
			PACPlumbLineAlignment |= plumbUpperBodyBehind;
			break;
		}
		break;
	case tableViewRowPelvis:
		PACPlumbLineAlignment &= ~plumbPelvisForward;
		PACPlumbLineAlignment &= ~plumbPelvisAligned;
		PACPlumbLineAlignment &= ~plumbPelvisBehind;
		switch(segment.selectedSegmentIndex) {
		case 0:
			PACPlumbLineAlignment |= plumbPelvisForward;
			break;
		case 1:
			PACPlumbLineAlignment |= plumbPelvisAligned;
			break;
		case 2:
			PACPlumbLineAlignment |= plumbPelvisBehind;
			break;

		}
		break;
	case tableViewRowKnees:
		PACPlumbLineAlignment &= ~plumbKneesForward;
		PACPlumbLineAlignment &= ~plumbKneesAligned;
		PACPlumbLineAlignment &= ~plumbKneesBehind;
		switch(segment.selectedSegmentIndex) {
		case 0:
			PACPlumbLineAlignment |= plumbKneesForward;
			break;
		case 1:
			PACPlumbLineAlignment |= plumbKneesAligned;
			break;
		case 2:
			PACPlumbLineAlignment |= plumbKneesBehind;
			break;

		}
		break;
	case tableViewRowRelativeAlignment:
		break;
	}

	if( ((PACPlumbLineAlignment & plumbHeadForward) == plumbHeadForward
	     || (PACPlumbLineAlignment & plumbHeadAligned) == plumbHeadAligned
	     || (PACPlumbLineAlignment & plumbHeadBehind) == plumbHeadBehind)
	    && ((PACPlumbLineAlignment & plumbShouldersForward) == plumbShouldersForward
	        || (PACPlumbLineAlignment & plumbShouldersAligned) == plumbShouldersAligned
	        || (PACPlumbLineAlignment & plumbShouldersBehind) == plumbShouldersBehind)
	    && ((PACPlumbLineAlignment & plumbUpperBodyForward) == plumbUpperBodyForward
	        || (PACPlumbLineAlignment & plumbUpperBodyAligned) == plumbUpperBodyAligned
	        || (PACPlumbLineAlignment & plumbUpperBodyBehind) == plumbUpperBodyBehind)
	    && ((PACPlumbLineAlignment & plumbPelvisForward) == plumbPelvisForward
	        || (PACPlumbLineAlignment & plumbPelvisAligned) == plumbPelvisAligned
	        || (PACPlumbLineAlignment & plumbPelvisBehind) == plumbPelvisBehind)
	    && ((PACPlumbLineAlignment & plumbKneesForward) == plumbKneesForward
	        || (PACPlumbLineAlignment & plumbKneesAligned) == plumbKneesAligned
	        || (PACPlumbLineAlignment & plumbKneesBehind) == plumbKneesBehind) 
            && ((PACPlumbLineAlignment & plumbRelativeAlign) == plumbRelativeAlign) ) {
		PACChecklistMain |= mainChecklistPlumbline;
	} else {
		PACChecklistMain &= ~mainChecklistPlumbline;
	}

	[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListMainDidChange] object:nil];


}
@end
