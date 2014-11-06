//
//  PACCervicalSpineViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/27/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACCervicalSpineViewController.h"
#import "PACGlobal.h"

enum {
        tagContentView = 100
            , tagTableView
};


static NSString*  cell_identifier_sideview_cervical_spine = @"cervical-spine-cell";

@interface PACCervicalSpineTableViewCell : UITableViewCell
@end


@implementation PACCervicalSpineTableViewCell 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
        self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        return self;
}
@end


@interface PACCervicalSpineViewController ()

@end

@implementation PACCervicalSpineViewController

- (void)viewDidLoad 
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void) loadView
{
    [super loadView];

    self.navigationItem.title = @"Cervical Spine";

    CGRect frame = self.view.frame;
    float fy = 5.0f;
    float fgutter = 5.0f;


    UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    content_view.tag = tagContentView;
    content_view.backgroundColor = [UIColor whiteColor];

    UIImage* image = [UIImage imageNamed:@"cervical_spine_detail.jpg"];

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

    [tableView registerClass:[PACCervicalSpineTableViewCell class] forCellReuseIdentifier:cell_identifier_sideview_cervical_spine ];

    fy = fy + 220.0f + 30.0f + fgutter;


    [self.view addSubview:content_view];

}

#pragma mark -
#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    PACCervicalSpineTableViewCell* cell = (PACCervicalSpineTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cell_identifier_sideview_cervical_spine forIndexPath:indexPath];


    switch(indexPath.row){
        case cervicalSpineAlignmentNeutral:
            cell.textLabel.text = @"Neutral";
            break;
        case cervicalSpineAlignmentFlat:
            cell.textLabel.text = @"Flat";
            cell.detailTextLabel.text = @"(decreased convex curve anteriorly)";
            break;
        case cervicalSpineAlignmentFlexed:
            cell.textLabel.text = @"Excessive extension";
            cell.detailTextLabel.text = @"(increased convex curve anteriorly)";
            break;
    }

    cell.accessoryType = ((indexPath.row == PACCervicalSpineAlignment) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);

    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, tableView.frame.size.width, 42.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = NSLocalizedString(@"● Feel C1 to C7 to get an idea of the curvature", @"");
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
    PACCervicalSpineAlignment = (int)indexPath.row;
    [tableView reloadData];

    if(!((PACChecklistSideView & sideViewCheckListCervicalSpine) == sideViewCheckListCervicalSpine)){
        PACChecklistSideView |= sideViewCheckListCervicalSpine;
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListSideViewDidChange] object:nil];
    }
}



@end
