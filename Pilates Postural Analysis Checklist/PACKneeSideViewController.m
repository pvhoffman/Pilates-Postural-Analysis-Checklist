//
//  PACKneeSideViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 10/23/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACKneeSideViewController.h"
#import "PACGlobal.h"

enum {
        tagContentView = 100
            , tagTableView
};

enum {
        tableViewRowLeftKnee = 0
            , tableViewRowRightKnee = 1
            , tableViewRowCount
};
static NSString* cell_identifier = @"knee-side-cell";


@interface PACKneeSideViewController ()
-(void) segmentvaluechanged:(id)sender;
@end

@implementation PACKneeSideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) loadView
{
    [super loadView];

    self.navigationItem.title = @"Knee - Side";

    CGRect frame = self.view.frame;
    float fy = 5.0f;
    float fgutter = 5.0f;


    UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    content_view.tag = tagContentView;
    content_view.backgroundColor = [UIColor whiteColor];

    UIImage* image = [UIImage imageNamed:@"knee_detail.png"];

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

    if(!cell.accessoryView){
        UISegmentedControl *segment = [[UISegmentedControl alloc] init];
        segment.frame = CGRectMake(0,0,260,30);
        segment.tag   = indexPath.row;
        [segment insertSegmentWithTitle:@"Neutral" atIndex:0 animated:NO];
        [segment insertSegmentWithTitle:@"Hyperextended" atIndex:1 animated:NO];
        [segment insertSegmentWithTitle:@"Flexed"  atIndex:2 animated:NO];
        [segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];
        
        cell.accessoryView = segment;
    }

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    switch(indexPath.row){
        case tableViewRowLeftKnee:
            cell.textLabel.text = @"Left Knee";
            ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = PACKneeAlignmentSideLeft;
            break;
        case tableViewRowRightKnee:
            cell.textLabel.text = @"Right Knee";
            ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = PACKneeAlignmentSideRight;
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
    label.text = NSLocalizedString(@"●Use greater trochanter and anterior to lateral malleolus and relate to plumb line", @"");
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
}
#pragma mark -
-(void) segmentvaluechanged:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl*)sender; 

    switch(segment.tag){
        case tableViewRowLeftKnee:
            PACKneeAlignmentSideLeft = segment.selectedSegmentIndex;
            break;
        case tableViewRowRightKnee:
            PACKneeAlignmentSideRight = segment.selectedSegmentIndex;
            break;
    }

    if(PACKneeAlignmentSideRight > -1 && PACKneeAlignmentSideLeft > -1){
        if(!((PACChecklistSideView & sideViewCheckListKnee) == sideViewCheckListKnee)){
            PACChecklistSideView |= sideViewCheckListKnee;
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListSideViewDidChange] object:nil];
        }
    } else {
        if((PACChecklistSideView & sideViewCheckListKnee) == sideViewCheckListKnee){
            PACChecklistSideView &= ~sideViewCheckListKnee;
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListSideViewDidChange] object:nil];
        }
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
