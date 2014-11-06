//
//  PACShouldersFrontViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/6/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACShouldersFrontViewController.h"
#import "PACGlobal.h"

enum {
        tagContentView = 100
            , tagTableView
};

enum {
        tableViewRowShouldersLevel = 0
            , tableViewRowShouldersLeft = 1
            , tableViewRowShouldersRight = 2
            , tableViewRowCount = 3
};
 

static NSString* cell_identifier = @"shoulders-front-cell";


@interface PACShouldersFrontViewController ()
-(void) segmentvaluechanged:(id)sender;
@end

@implementation PACShouldersFrontViewController
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

    self.navigationItem.title = @"Shoulders";

    CGRect frame = self.view.frame;
    float fy = 5.0f;
    float fgutter = 5.0f;


    UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    content_view.tag = tagContentView;
    content_view.backgroundColor = [UIColor whiteColor];

    UIImage* image = [UIImage imageNamed:@"shoulder_front_detail.png"];

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

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 30.0f, frame.size.width - 3.0f, 350.0f) style:UITableViewStyleGrouped];
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

    if(indexPath.row == tableViewRowShouldersLevel){ 
        cell.accessoryType = ((PACShouldersFrontAlignment == shouldersFrontAlignmentLevel) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone);
        cell.accessoryView = nil;
    } else {
        if(!cell.accessoryView){
            UISegmentedControl *segment = [[UISegmentedControl alloc] init];
            segment.frame = CGRectMake(0,0,230,30);
            segment.tag   = indexPath.row;
            [segment insertSegmentWithTitle:@"Elevated" atIndex:0 animated:NO];
            [segment insertSegmentWithTitle:@"Depressed" atIndex:1 animated:NO];
            [segment addTarget:self action:@selector(segmentvaluechanged:) forControlEvents:UIControlEventValueChanged];

            cell.accessoryView = segment;
        }
    }

    switch(indexPath.row){
        case tableViewRowShouldersLevel:
            cell.textLabel.text = @"Level";
            break;
        case tableViewRowShouldersLeft:
            cell.textLabel.text = @"Left";
            ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = -1;
            if((PACShouldersFrontAlignment & shouldersFrontAlignmentElevatedLeft) == shouldersFrontAlignmentElevatedLeft){
                ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
            } else if((PACShouldersFrontAlignment & shouldersFrontAlignmentDepressedLeft) == shouldersFrontAlignmentDepressedLeft){
                ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 1;
            }
            break;
        case tableViewRowShouldersRight:
            cell.textLabel.text = @"Right";
            ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = -1;
            if((PACShouldersFrontAlignment & shouldersFrontAlignmentElevatedRight) == shouldersFrontAlignmentElevatedRight){
                ((UISegmentedControl*)cell.accessoryView).selectedSegmentIndex = 0;
            } else if((PACShouldersFrontAlignment & shouldersFrontAlignmentDepressedRight) == shouldersFrontAlignmentDepressedRight){
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
    label.text = NSLocalizedString(@"● Palpate along the clavicle to the acromion process and compare", @"");
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
    if(indexPath.row == tableViewRowShouldersLevel){
        PACShouldersFrontAlignment = shouldersFrontAlignmentLevel;
        [tableView reloadData];

        if(!((PACChecklistFrontView & frontViewCheckListShoulders) == frontViewCheckListShoulders)){
            PACChecklistFrontView |= frontViewCheckListShoulders;
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
        }

    } 
}
#pragma mark -
-(void) segmentvaluechanged:(id)sender
{
    UISegmentedControl* segment = (UISegmentedControl*)sender;
    if(segment.tag == tableViewRowShouldersLeft){
        switch(segment.selectedSegmentIndex){
            case 0: // left elevated
                PACShouldersFrontAlignment &= ~shouldersFrontAlignmentLevel;
                PACShouldersFrontAlignment &= ~shouldersFrontAlignmentDepressedLeft;
                PACShouldersFrontAlignment |= shouldersFrontAlignmentElevatedLeft;
                break;
            case 1: // left depressed 
                PACShouldersFrontAlignment &= ~shouldersFrontAlignmentLevel;
                PACShouldersFrontAlignment &= ~shouldersFrontAlignmentElevatedLeft;
                PACShouldersFrontAlignment |= shouldersFrontAlignmentDepressedLeft;
                break;
        }
    } else if(segment.tag == tableViewRowShouldersRight){
        switch(segment.selectedSegmentIndex){
            case 0: // right elevated
                PACShouldersFrontAlignment &= ~shouldersFrontAlignmentLevel;
                PACShouldersFrontAlignment &= ~shouldersFrontAlignmentDepressedRight;
                PACShouldersFrontAlignment |= shouldersFrontAlignmentElevatedRight;
                break;
            case 1: // right depressed
                PACShouldersFrontAlignment &= ~shouldersFrontAlignmentLevel;
                PACShouldersFrontAlignment &= ~shouldersFrontAlignmentElevatedRight;
                PACShouldersFrontAlignment |= shouldersFrontAlignmentDepressedRight;
                break;
        }
    }

    UITableView* tableView = (UITableView*)[[self.view viewWithTag:tagContentView] viewWithTag:tagTableView];
    [tableView reloadData];

    if(!((PACChecklistFrontView & frontViewCheckListShoulders) == frontViewCheckListShoulders)){
        PACChecklistFrontView |= frontViewCheckListShoulders;
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
    }
}

@end
