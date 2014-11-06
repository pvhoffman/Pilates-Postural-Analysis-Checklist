//
//  PACRibCageViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 11/6/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACRibCageViewController.h"
#import "PACGlobal.h"

enum {
        tagContentView = 100
            , tagTableView
};

enum {
        tableViewRowRibCageNeutral = 0
            , tableViewRowRibCageElevatedLeft = 1
            , tableViewRowRibCageElevatedRight = 2
            , tableViewRowRibCageShiftedLeft = 3
            , tableViewRowRibCageShiftedRight = 4
            , tableViewRowRibCageRotatedClockwise = 5
            , tableViewRowRibCageRotatedCounterClockwise = 6
            , tableViewRowCount = 7
};

static NSString* cell_identifier = @"ribcage-front-cell";


@interface PACRibCageViewController ()

@end

@implementation PACRibCageViewController

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

    self.navigationItem.title = @"Rib Cage";

    CGRect frame = self.view.frame;
    float fy = 5.0f;
    float fgutter = 5.0f;


    UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    content_view.tag = tagContentView;
    content_view.backgroundColor = [UIColor whiteColor];

    UIImage* image = [UIImage imageNamed:@"ribcage_front_detail.jpg"];

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

    cell.accessoryType = UITableViewCellAccessoryNone;


    switch(indexPath.row){
        case tableViewRowRibCageNeutral:
            cell.textLabel.text = @"Neutral";
            if(PACRibCageFrontAlignment == ribCageAlignmentNeutral){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } 
            break;
        case tableViewRowRibCageElevatedLeft:
            cell.textLabel.text = @"Left Elevated";
            if(PACRibCageFrontAlignment > 0 && (PACRibCageFrontAlignment & ribCageAlignmentElevatedLeft) == ribCageAlignmentElevatedLeft){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } 
            break;
        case tableViewRowRibCageElevatedRight:
            cell.textLabel.text = @"Right Elevated";
            if(PACRibCageFrontAlignment > 0 && (PACRibCageFrontAlignment & ribCageAlignmentElevatedRight) == ribCageAlignmentElevatedRight){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } 
            break;
        case tableViewRowRibCageShiftedLeft:
            cell.textLabel.text = @"Left Shifted";
            if(PACRibCageFrontAlignment > 0 && (PACRibCageFrontAlignment & ribCageAlignmentShiftedLeft) == ribCageAlignmentShiftedLeft){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } 
            break;
        case tableViewRowRibCageShiftedRight:
            cell.textLabel.text = @"Right Shifted";
            if(PACRibCageFrontAlignment > 0 && (PACRibCageFrontAlignment & ribCageAlignmentShiftedRight) == ribCageAlignmentShiftedRight){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } 
            break;
        case tableViewRowRibCageRotatedClockwise:
            cell.textLabel.text = @"Rotated Clockwise";
            if(PACRibCageFrontAlignment > 0 && (PACRibCageFrontAlignment & ribCageAlignmentRotatedClockwise) == ribCageAlignmentRotatedClockwise){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } 
            break;
        case tableViewRowRibCageRotatedCounterClockwise:
            cell.textLabel.text = @"Rotated Counter-Clockwise";
            if(PACRibCageFrontAlignment > 0 && (PACRibCageFrontAlignment & ribCageAlignmentRotatedCounterClockwise) == ribCageAlignmentRotatedCounterClockwise){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
    label.text = NSLocalizedString(@"● Palpate ASIS and ribcage and compare. Look at sternum to check for rotation.", @"");
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
    if(PACRibCageFrontAlignment < 0){
        PACRibCageFrontAlignment = ribCageAlignmentNeutral;
    }

    if(indexPath.row == tableViewRowRibCageNeutral){
        PACRibCageFrontAlignment = ribCageAlignmentNeutral;
    } else if(indexPath.row == tableViewRowRibCageElevatedLeft){
        PACRibCageFrontAlignment &= ~ribCageAlignmentElevatedRight;
        PACRibCageFrontAlignment |= ribCageAlignmentElevatedLeft;
    } else if(indexPath.row == tableViewRowRibCageElevatedRight){
        PACRibCageFrontAlignment &= ~ribCageAlignmentElevatedLeft;
        PACRibCageFrontAlignment |= ribCageAlignmentElevatedRight;
    } else if(indexPath.row == tableViewRowRibCageShiftedLeft){
        PACRibCageFrontAlignment &= ~ribCageAlignmentShiftedRight ;
        PACRibCageFrontAlignment |= ribCageAlignmentShiftedLeft;
    } else if(indexPath.row == tableViewRowRibCageShiftedRight){
        PACRibCageFrontAlignment &= ~ribCageAlignmentShiftedLeft;
        PACRibCageFrontAlignment |= ribCageAlignmentShiftedRight;
    } else if(indexPath.row == tableViewRowRibCageRotatedClockwise){
        PACRibCageFrontAlignment &= ~ribCageAlignmentRotatedCounterClockwise;
        PACRibCageFrontAlignment |= ribCageAlignmentRotatedClockwise;
    } else if(indexPath.row == tableViewRowRibCageRotatedCounterClockwise){
        PACRibCageFrontAlignment &= ~ribCageAlignmentRotatedClockwise;
        PACRibCageFrontAlignment |= ribCageAlignmentRotatedCounterClockwise;
    }

    [tableView reloadData];

    if(!((PACChecklistFrontView & frontViewCheckListRibcage) == frontViewCheckListRibcage)){
        PACChecklistFrontView |= frontViewCheckListRibcage;
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListFrontViewDidChange] object:nil];
    }
}
@end
