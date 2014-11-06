//
//  PACFeetFrontViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/5/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACFeetFrontViewController.h"
#import "PACGlobal.h"

enum {
        tagContentView = 100
            , tagTableView
};

enum {
        tableViewRowLeftFoot = 0
            , tableViewRowRightFoot = 1
            , tableViewRowCount
};
static NSString* cell_identifier = @"foot-front-cell";


@interface PACFeetFrontViewController ()
-(void) segmentvaluechanged:(id)sender;
@end

@implementation PACFeetFrontViewController

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

    self.navigationItem.title = @"Feet - Front";

    CGRect frame = self.view.frame;
    float fy = 5.0f;
    float fgutter = 5.0f;


    UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    content_view.tag = tagContentView;
    content_view.backgroundColor = [UIColor whiteColor];

    UIImage* image = [UIImage imageNamed:@"feet_front_detail.jpg"];

    UIImageView* image_view = [[UIImageView alloc] initWithFrame:CGRectMake( (frame.size.width / 2.0f) - (image.size.width / 2.0f), fy, image.size.width, image.size.height)];
    image_view.image = image;
    [content_view addSubview:image_view];

    fy = fy + image.size.height + fgutter;

    UIImage* look = [UIImage imageNamed:@"look.jpg"];
    UIImageView* look_view = [[UIImageView alloc] initWithFrame:CGRectMake( 5.0f, fy, look.size.width, look.size.height )];
    look_view.image = look;
    [content_view addSubview:look_view];

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_identifier];
        cell.accessoryView = nil;
    }

    if(!cell.accessoryView){
        UISegmentedControl *segment = [[UISegmentedControl alloc] init];
        segment.frame = CGRectMake(0,0,260,30);
        segment.tag   = indexPath.row;
        [segment insertSegmentWithTitle:@"Neutral" atIndex:0 animated:NO];
        [segment insertSegmentWithTitle:@"Supinated" atIndex:1 animated:NO];
        [segment insertSegmentWithTitle:@"Pronated"  atIndex:2 animated:NO];
        [segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];
        
        cell.accessoryView = segment;
    }

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    switch(indexPath.row){
        case tableViewRowLeftFoot:
            cell.textLabel.text = @"Left Foot";
            ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = PACFeetFrontAlignmentLeft;
            break;
        case tableViewRowRightFoot:
            cell.textLabel.text = @"Right Foot";
            ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = PACFeetFrontAlignmentRight;
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
    label.text = NSLocalizedString(@"● Distinguish where the weight is distributed on the foot", @"");
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
        case tableViewRowLeftFoot:
            PACFeetFrontAlignmentLeft = (int)segment.selectedSegmentIndex;
            break;
        case tableViewRowRightFoot:
            PACFeetFrontAlignmentRight = (int)segment.selectedSegmentIndex;
            break;
    }
    if(PACFeetFrontAlignmentLeft > -1 && PACFeetFrontAlignmentRight > -1){
        if(!((PACChecklistFrontView & frontViewCheckListFeet) == frontViewCheckListFeet)){
            PACChecklistFrontView = PACChecklistFrontView | frontViewCheckListFeet;
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
        }
    } else {
        if((PACChecklistFrontView & frontViewCheckListFeet) == frontViewCheckListFeet){
                PACChecklistFrontView &= ~frontViewCheckListFeet;
                [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
        }
    }
/*
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
*/
}


@end
