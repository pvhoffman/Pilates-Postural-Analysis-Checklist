//
//  PACScapulaeBackViewController.m
//  Pilates Postural Analysis Checklist
//
//  Created by Paul Hoffman on 12/1/14.
//  Copyright (c) 2014 Paul Hoffman. All rights reserved.
//

#import "PACScapulaeBackViewController.h"
#import "PACGlobal.h"

enum {
        tagContentView = 100
            , tagTableView
            , tagTableViewLeft
            , tagTableViewRight
};


enum {
    tableViewSectionCount = 1
};

enum {
    tableViewRowScapulaeLeft        = 0
        , tableViewRowScapulaeRight = 1
        , tableViewRowCount         = 2
};

enum {
   tableView2RowScapulaeNeutral            = 0
        , tableView2RowScapulaeProtracted  = 1
        , tableView2RowScapulaeRetracted   = 2
        , tableView2RowScapulaeElevated    = 3
        , tableView2RowScapulaeDepressed   = 4
        , tableView2RowScapulaeRotatedUp   = 5
        , tableView2RowScapulaeRotatedDown = 6
        , tableView2RowScapulaeWinging     = 7
        , tableView2RowScapulaeTipping     = 8
        , tableView2RowCount               = 9
};

static NSString* cell_identifier  = @"scapulae-back-cell";
static NSString* cell_identifier2 = @"scapulae-back-cell2";

@interface PACScapulaeBackViewController ()
- (UITableViewCell *)cellForRowAtIndexPath1:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForRowAtIndexPath2:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForRowAtIndexPathLeft:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (UITableViewCell *)cellForRowAtIndexPathRight:(UITableView*)tableView at:(NSIndexPath*)indexPath;
- (NSInteger) numberOfRowsInSection1:(NSInteger)section;
- (NSInteger) numberOfRowsInSection2:(NSInteger)section;
- (void) didSelectRowAtIndexPath1:(UITableView*)tableView at:(NSIndexPath *)indexPath;
- (void) didSelectRowAtIndexPath2:(UITableView*)tableView at:(NSIndexPath *)indexPath;
@end

@implementation PACScapulaeBackViewController

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

    self.navigationItem.title = @"Scapulae - Back";

    CGRect frame = self.view.frame;
    float fy = 5.0f;
    float fgutter = 5.0f;


    UIScrollView* content_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    content_view.tag = tagContentView;
    content_view.backgroundColor = [UIColor whiteColor];

    UIImage* image = [UIImage imageNamed:@"scapulae_back_detail.jpg"];

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

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 30.0f, frame.size.width - 3.0f, 320.0f) style:UITableViewStyleGrouped];
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
- (UITableViewCell *)cellForRowAtIndexPath1:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryNone;

    switch(indexPath.row){
        case tableViewRowScapulaeLeft:
            cell.textLabel.text = @"Left Side";
            if(PACScapulaeBackAlignmentLeft > -1){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;
        case tableViewRowScapulaeRight:
            cell.textLabel.text = @"Right Side";
            if(PACScapulaeBackAlignmentRight > -1){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;
    }
    return cell;
}
- (UITableViewCell *)cellForRowAtIndexPath2:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier2 forIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryNone;

    switch(indexPath.row){
        case tableView2RowScapulaeNeutral:
            cell.textLabel.text = @"Neutral";
            break;
        case tableView2RowScapulaeProtracted:
            cell.textLabel.text = @"Protracted";
            break;
        case tableView2RowScapulaeRetracted:
            cell.textLabel.text = @"Retracted";
            break;
        case tableView2RowScapulaeElevated:
            cell.textLabel.text = @"Elevated";
            break;
        case tableView2RowScapulaeDepressed:
            cell.textLabel.text = @"Depressed";
            break;
        case tableView2RowScapulaeRotatedUp:
            cell.textLabel.text = @"Rotated Upward";
            break;
        case tableView2RowScapulaeRotatedDown:
            cell.textLabel.text = @"Rotated Downward";
            break;
        case tableView2RowScapulaeWinging:
            cell.textLabel.text = @"Winging";
            break;
        case tableView2RowScapulaeTipping:
            cell.textLabel.text = @"Tipping";
            break;
    }
    return cell;
}
- (UITableViewCell *)cellForRowAtIndexPathLeft:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [self cellForRowAtIndexPath2:tableView at:indexPath];
    if(indexPath.row == PACScapulaeBackAlignmentLeft){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}
- (UITableViewCell *)cellForRowAtIndexPathRight:(UITableView*)tableView at:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [self cellForRowAtIndexPath2:tableView at:indexPath];
    if(indexPath.row == PACScapulaeBackAlignmentRight){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    switch(tableView.tag){
        case tagTableView:
            return [self cellForRowAtIndexPath1:tableView at:indexPath];
        case tagTableViewLeft:
            return [self cellForRowAtIndexPathLeft:tableView at:indexPath];
        case tagTableViewRight:
            return [self cellForRowAtIndexPathRight:tableView at:indexPath];
    }
    return nil;
} 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return tableViewSectionCount;
}
- (NSInteger) numberOfRowsInSection1:(NSInteger)section
{
    return tableViewRowCount;
}
- (NSInteger) numberOfRowsInSection2:(NSInteger)section
{
    return tableView2RowCount;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(tableView.tag){
        case tagTableView:
            return [self numberOfRowsInSection1:section];
        case tagTableViewLeft:
        case tagTableViewRight:
            return [self numberOfRowsInSection2:section];
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == tagTableView){
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0f, tableView.frame.size.width, 42.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.text = NSLocalizedString(@"● Palpate inferior angle, superior angle, medial border of each scapula.\r\n● Compare distance to spinous process.", @"");
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        return label;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == tagTableView){
	return 62.0f;
    }
    return 0.0f;
}
#pragma mark -
#pragma mark UITableViewDelegate
- (void) didSelectRowAtIndexPath1:(UITableView*)tableView at:(NSIndexPath *)indexPath
{
    UITableView* table_view = [[UITableView alloc] initWithFrame:tableView.frame style:UITableViewStylePlain];
    table_view.tag = ((indexPath.row == tableViewRowScapulaeLeft) ? tagTableViewLeft : tagTableViewRight);
    table_view.scrollEnabled = YES;
    table_view.dataSource = self;
    table_view.delegate   = self;
    [table_view registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier2];

    [UIView transitionFromView:tableView toView:table_view duration:0.45 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished){}];
}
- (void) didSelectRowAtIndexPath2:(UITableView*)tableView at:(NSIndexPath *)indexPath
{
    switch(tableView.tag){
        case tagTableViewLeft:
            PACScapulaeBackAlignmentLeft = (int)indexPath.row;
            break;
        case tagTableViewRight:
            PACScapulaeBackAlignmentRight = (int)indexPath.row;
            break;
    }

    UITableView* table_view = [[UITableView alloc] initWithFrame:tableView.frame style:UITableViewStyleGrouped];
    table_view.tag = tagTableView;
    table_view.scrollEnabled = NO;
    table_view.dataSource = self;
    table_view.delegate   = self;
    [table_view registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier];

    [UIView transitionFromView:tableView toView:table_view duration:0.45 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished){}];

    if(PACScapulaeBackAlignmentLeft > -1 && PACScapulaeBackAlignmentRight > -1){
        if(!((PACChecklistBackView & backViewCheckListScapulae) == backViewCheckListScapulae)){
            PACChecklistBackView |= backViewCheckListScapulae;
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListBackViewDidChange] object:nil];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(tableView.tag){
        case tagTableView:
            [self didSelectRowAtIndexPath1:tableView at:indexPath];
            break;
        case tagTableViewLeft:
            [self didSelectRowAtIndexPath2:tableView at:indexPath];
            break;
        case tagTableViewRight:
            [self didSelectRowAtIndexPath2:tableView at:indexPath];
            break;
    }
}
@end
