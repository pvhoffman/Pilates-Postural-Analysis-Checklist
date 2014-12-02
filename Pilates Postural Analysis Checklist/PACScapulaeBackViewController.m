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
};


enum {
        tableViewSectionLeft        = 0
            , tableViewSectionRight = 1
            , tableViewSectionCount = 2
};

enum {
   tableViewRowScapulaeNeutral            = 0
        , tableViewRowScapulaeProtracted  = 1
        , tableViewRowScapulaeRetracted   = 2
        , tableViewRowScapulaeElevated    = 3
        , tableViewRowScapulaeDepressed   = 4
        , tableViewRowScapulaeRotatedUp   = 5
        , tableViewRowScapulaeRotatedDown = 6
        , tableViewRowScapulaeWinging     = 7
        , tableViewRowScapulaeTipping     = 8
        , tableViewRowCount               = 9
};

static NSString* cell_identifier = @"scapulae-back-cell";

@interface PACScapulaeBackViewController ()
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

    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(5.0, fy, frame.size.width, 62.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = NSLocalizedString(@"● Palpate inferior angle, superior angle, medial border of each scapula.\r\n● Compare distance to spinous process.", @"");
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [content_view addSubview:label];

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(3.0f, fy + 63.0f, frame.size.width - 3.0f, 350.0f) style:UITableViewStyleGrouped];
    tableView.tag = tagTableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = YES;//NO;
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
        case tableViewRowScapulaeNeutral:
            cell.textLabel.text = @"Neutral";
            break;
        case tableViewRowScapulaeProtracted:
            cell.textLabel.text = @"Protracted";
            break;
        case tableViewRowScapulaeRetracted:
            cell.textLabel.text = @"Retracted";
            break;
        case tableViewRowScapulaeElevated:
            cell.textLabel.text = @"Elevated";
            break;
        case tableViewRowScapulaeDepressed:
            cell.textLabel.text = @"Depressed";
            break;
        case tableViewRowScapulaeRotatedUp:
            cell.textLabel.text = @"Rotated Upward";
            break;
        case tableViewRowScapulaeRotatedDown:
            cell.textLabel.text = @"Rotated Downward";
            break;
        case tableViewRowScapulaeWinging:
            cell.textLabel.text = @"Winging";
            break;
        case tableViewRowScapulaeTipping:
            cell.textLabel.text = @"Tipping";
            break;
    }

    if(indexPath.section == tableViewSectionLeft){
        if(PACScapulaeBackAlignmentLeft == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else if(indexPath.section == tableViewSectionRight){
        if(PACScapulaeBackAlignmentRight == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }

    return cell;
} 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return tableViewSectionCount;
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
    if(section == tableViewSectionLeft){
        label.text = NSLocalizedString(@"Left Side", @"");
    } else if(section == tableViewSectionRight){
        label.text = NSLocalizedString(@"Right Side", @"");
    }
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	return 34.0f;
}
#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int* var = (indexPath.section == tableViewSectionLeft) ? &PACScapulaeBackAlignmentLeft : &PACScapulaeBackAlignmentRight;

    *var = (int)indexPath.row;

    [tableView reloadData];

    if(!((PACChecklistBackView & backViewCheckListScapulae) == backViewCheckListScapulae)){
        PACChecklistBackView |= backViewCheckListScapulae;
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithUTF8String:PACCheckListBackViewDidChange] object:nil];
    }
}
@end
